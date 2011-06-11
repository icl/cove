class VideosController < ApplicationController
  def new
    #new video to fill stuff in the view
    @video = Video.new

    render "new"
  end

  def index
    @videos = Video.all

    render "index"
  end

  def create


    @video = Video.new(params[:video])
    @video.video_up = params[:video][:video_up]
    if @video.save
      redirect_to(@video, :notice => 'Interval was successfully created.')
    else
      render :action => "new"
    end

  end

  def show
    @video = Video.find(params[:id])
    
    render "show"
    endcoveTag.setPostURL('/videos/#{@video.id}/tag');
  end

  def tag
    @tagging = VideoTag.new(:video_id => params[:video_id], :job_id => params[:job_id], :tag_id => params[:tag_id], :start_time => params[:start_time], :end_time => params[:end_time], :user => current_user)
    
    respond_to do |format|
      if @tagging.save
        format.json { render :json => @tagging, :status => :created }
      else
        format.json { render :json => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end 

 def lookup


 end 
end

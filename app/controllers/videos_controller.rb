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
    @video = Video.add_file params #offloaded to model
    
    if @video.save
      redirect_to(@video, :notice => 'Interval was successfully created.')
    else
      render :action => "new"
    end

  end

  def show
    @video = Video.find(params[:id])
    
    render "show"
  end

  def tag
    @tagging = VideoTag.new(:video_id => params[:video_id], :tag_id => params[:tag_id], :start_time => params[:start_time], :end_time => params[:end_time]);
    
    respond_to do |format|
      if @tagging.save
        format.json { render :json => @tagging, :status => :created }
      else
        format.json { render :json => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end  
end

#Video file uploader
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
end

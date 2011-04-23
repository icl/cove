#Video file uploader
class VideosController < ApplicationController

  def new
    #new video to fill stuff in the view
    @video = Video.new

    render "new"
  end
end

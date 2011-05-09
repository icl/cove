class VideosController < ApplicationController
  def tag
    @tagging = VideoTag.new(:video_id => params[:video_id], :tag_id => params[:tag_id], :start_time => params[:start_time], :end_time => params[:end_time], :user_id => current_user.id);
    
    respond_to do |format|
      if @tagging.save
        format.json { render :json => @tagging, :status => :created }
      else
        format.json { render :json => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end  
end

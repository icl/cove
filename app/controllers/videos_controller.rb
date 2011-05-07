class VideosController < ApplicationController
  def tag
    @coding = Videocode.new(:video_id => params[:video_id], :code_id => params[:code_id], :start_time => params[:start_time], :end_time => params[:end_time]);
    
    respond_to do |format|
      if @coding.save
        format.json { render :json => @coding, :status => :created }
      else
        format.json { render :json => @coding.errors, :status => :unprocessable_entity }
      end
    end
  end  
end

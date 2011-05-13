class LoggingsController < ApplicationController
  respond_to :json
  def create
    Rails.event_log.write(params[:data])
    respond_with do |format|
      format.json { render :json => {:status => "success"} }
    end
  end
end

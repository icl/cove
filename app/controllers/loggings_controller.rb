class LoggingsController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!
  
  def create
    uuid = ActiveSupport::SecureRandom.hex(12)
    timestamp = DateTime.now.to_s
    log_data = { "timestamp" => timestamp, "_id" => uuid, "data" => params[:data] }
    Rails.event_log.write(JSON.dump(log_data))
    respond_with do |format|
      format.json { render :json => {:status => "success"} }
    end
  end
end

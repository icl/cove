module ApplicationHelper

  def  video_service_url file_name
    url = TAVideoServer::Client.generate_url(file_name)
  end

end

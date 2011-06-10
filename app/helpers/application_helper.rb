module ApplicationHelper

  def  video_service_url file_name
    url = TAVideoServer::Client.generate_url(file_name) if !file_name.blank? && file_name.match(/.*\..*/)
  end

end

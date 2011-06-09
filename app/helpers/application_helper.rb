module ApplicationHelper
  
  def  video_service_url file_name

  token = "#{CoveConfig.video_prefix}/#{get_video_token(file_name)}/#{file_name}"
  
  
  
  end
  
  def get_video_token file_name
    puts "#{CoveConfig.token_prefix}?video=#{file_name}"
    JSON.parse(RestClient.get "#{CoveConfig.token_prefix}?video=#{file_name}" )['token']
    
  end

end

class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :video_id
  
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader
  
end

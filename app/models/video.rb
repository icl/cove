class Video < ActiveRecord::Base
  attr_acessible :filepath, :name, :video_id
  
  #mount uploader for carrierwave
  mount_uploader :image, ImageUploader
  
end

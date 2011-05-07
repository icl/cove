class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :video_id
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader

	has_many :jobvideos
	has_many :jobs, :through => :jobvideos
	has_many :videocodes
	has_many :codes, :through => :videocodes

end

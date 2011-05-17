class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :video_id
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader

	has_many :job_videos
	has_many :jobs, :through => :job_videos
	has_many :video_tags
	has_many :tags, :through => :video_tags

end

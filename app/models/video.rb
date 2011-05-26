class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :duration, :source_cam, :project, :cam_type, :location, :orig_res, :starttime, :created_at, :updated_at, :orig_filepath, :source_cam, :project, :comments
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader

	has_many :job_videos
	has_many :jobs, :through => :job_videos
	has_many :video_tags
	has_many :tags, :through => :video_tags

end

class Video < ActiveRecord::Base
	has_many :job_videos
	has_many :jobs, :through => :job_videos
	has_many :video_tags
	has_many :tags, :through => :video_tags
end

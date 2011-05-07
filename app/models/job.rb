class Job < ActiveRecord::Base
	has_many :job_tags
	has_many :tags, :through => :job_tags
	has_many :job_videos
	has_many :videos, :through => :job_videos
	#has_and_belongs_to_many :videos
	#has_and_belongs_to_many :tags

	def video_names 
		videos.map{|v| v.name}
	end
	def tag_names
		tags.map{|c| t.name}
	end
end

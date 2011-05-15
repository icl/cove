class Training < ActiveRecord::Base
	has_many :training_tags
	has_many :tags, :through => :training_tags
	has_many :training_videos
	has_many :videos, :through => :training_videos

	def video_names 
		videos.map{|v| v.name}
	end
	def tag_names
		tags.map{|t| t.name}
	end
end

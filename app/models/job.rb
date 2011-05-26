class Job < ActiveRecord::Base
	has_many :job_tags
	has_many :tags, :through => :job_tags
	has_many :job_videos
	has_many :videos, :through => :job_videos
	has_many :work_records
	belongs_to :requestor, :class_name => "User"

	delegate :name, :to => :requestor, :prefix => true, :allow_nil => true

	validate :must_have_videos, :must_have_tags

	def must_have_videos
		errors.add(:videos, "must have at least one selected") if videos.length == 0
	end
	def must_have_tags
		errors.add(:tags, "must have at least one selected") if tags.length == 0
	end


	#result will be job.requestor_name
	def video_names 
		videos.map{|v| v.name}
	end
	def tag_names
		tags.map{|t| t.name}
	end
	def next_joblet(user)
		# this should return the next video to show to a user
		v = videos.first
		self.work_records.create(:video => v, :user => user)
		v 
	end
end

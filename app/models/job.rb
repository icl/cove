class Job < ActiveRecord::Base
	has_many :job_tags
	has_many :tags, :through => :job_tags
	has_many :job_videos
	has_many :videos, :through => :job_videos
	has_many :work_records
	belongs_to :requestor, :class_name => "User", :foreign_key => "requestor_id"
	#has_and_belongs_to_many :videos
	#has_and_belongs_to_many :tags

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

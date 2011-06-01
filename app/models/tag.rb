class Tag < ActiveRecord::Base
	has_many :job_tags
	has_many :jobs, :through => :job_tags
	has_many :video_tags
	has_many :videos, :through => :video_tags
	has_one :certification
	
	before_create :build_certification
	  
end

class Job < ActiveRecord::Base
	has_many :jobcodes
	has_many :codes, :through => :jobcodes
	has_many :jobvideos
	has_many :videos, :through => :jobvideos
	#has_and_belongs_to_many :videos
	#has_and_belongs_to_many :codes

	def videonames 
		videos.map{|v| v.name}
	end
	def codenames
		codes.map{|c| c.name}
	end
end

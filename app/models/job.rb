class Job < ActiveRecord::Base
	has_many :jobcodes
	has_many :codes, :through => :jobcodes
	has_many :jobvideos
	has_many :videos, :through => :jobvideos
end

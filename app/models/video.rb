class Video < ActiveRecord::Base
	has_many :jobvideos
	has_many :jobs, :through => :jobvideos
	has_many :videocodes
	has_many :codes, :through => :videocodes
end

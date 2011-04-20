class Video < ActiveRecord::Base
	has_many :jobvideos
	has_many :jobs, :through => :jobvideos
end

class Code < ActiveRecord::Base
	has_many :jobcodes
	has_many :jobs, :through => :jobcodes
	has_many :videocodes
	has_many :videos, :through => :videocodes
end

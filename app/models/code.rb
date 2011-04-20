class Code < ActiveRecord::Base
	has_many :jobcodes
	has_many :jobs, :through => :jobcodes
end

class Jobcode < ActiveRecord::Base
	belongs_to :job
	belongs_to :code
end

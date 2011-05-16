class JobTag < ActiveRecord::Base
	belongs_to :job
	belongs_to :tag
end

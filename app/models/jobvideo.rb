class Jobvideo < ActiveRecord::Base
	belongs_to :job
	belongs_to :video
end

class Videocode < ActiveRecord::Base
	belongs_to :video
	belongs_to :code
	belongs_to :user
	belongs_to :job
end

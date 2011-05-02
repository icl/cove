class Videocode < ActiveRecord::Base
	belongs_to :video
	belongs_to :code
	belongs_to :user
	belongs_to :job

	def length
		end_time - start_time
	end

	def length=(newlen)
		end_time = start_time + newlen
	end
end

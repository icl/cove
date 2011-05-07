class VideoTag < ActiveRecord::Base
	belongs_to :video
	belongs_to :tag
	belongs_to :user
	belongs_to :job

	def length
		end_time - start_time
	end
	def length=(newlen)
		st = read_attribute(:start_time);
		write_attribute(:end_time, st + newlen)
	end
end

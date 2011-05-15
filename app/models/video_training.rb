class VideoTraining < ActiveRecord::Base
	has_many :training_videos
	has_many :trainings, :through => :training_videos
end

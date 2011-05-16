class VideoTraining < ActiveRecord::Base
	has_many :training_videos
	has_many :trainings, :through => :training_videos

   validates :name, :presence => true,
                     :uniqueness => true, 
                     :length   => { :maximum => 50 }

   validates :filepath, :presence => true,
                     :uniqueness => true,
                     :length   => { :maximum => 255 }
end

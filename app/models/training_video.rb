class TrainingVideo < ActiveRecord::Base
   belongs_to :training
   belongs_to :video_training
end

class TrainingTag < ActiveRecord::Base
	belongs_to :training
	belongs_to :tag
end

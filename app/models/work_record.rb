class WorkRecord < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  belongs_to :video
end

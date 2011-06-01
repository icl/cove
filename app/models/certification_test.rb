class CertificationTest < ActiveRecord::Base
  belongs_to :certification_video
  belongs_to :user
  delegate :certification, :to => :certification_video
end

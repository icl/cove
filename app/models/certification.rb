class Certification < ActiveRecord::Base
  belongs_to :tag
  has_many :certification_videos
  has_many :videos, :through => :certification_videos 
end

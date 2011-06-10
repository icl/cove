class Certification < ActiveRecord::Base
  belongs_to :tag
  has_many :certification_videos
  has_many :videos, :through => :certification_videos 

  def seeded?
    self.certification_videos.any? { |cv| cv.seeded? }
  end
end

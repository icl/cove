class CertificationVideo < ActiveRecord::Base
  belongs_to :certification
  belongs_to :video
  belongs_to :seeder, :class_name => "User"
  has_many :certification_tests
  
  def tags
    if self.seeder.nil? then
      nil
    else
      VideoTag.find_by_video_id_and_user_id(self.video, self.seeder)
    end
  end
  
  def seeded?
    not self.seeder.nil?
  end
end

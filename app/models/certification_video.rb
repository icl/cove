class CertificationVideo < ActiveRecord::Base
  belongs_to :certification
  belongs_to :video
  has_many :certification_tests
end

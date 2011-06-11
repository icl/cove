class CertificationTestTag < ActiveRecord::Base
  belongs_to :certification_test
  belongs_to :tag
end

class User < ActiveRecord::Base
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :kind

  has_many :jobs
  has_many :user_certifications
  has_many :certifications, :through => :user_certifications
  
  def has_certification?(certification)
    self.certifications.include? certification
  end
  
  def certified_for_tag?(tag)
    self.certifications.any? { |c| c.tag == tag }
  end
end

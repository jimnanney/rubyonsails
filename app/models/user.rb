class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password
  before_save  :downcase_email
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email
  validates :password, :length => { :minimum => 8  }
  validates :name,     :length => { :maximum => 50 }
  validates :email,    :format => { :with => VALID_EMAIL_REGEX }
  validates :password_confirmation, :length => { :minimum => 8 }

  private
  def downcase_email
    return false unless self.email.present?
    write_attribute(:email, read_attribute(:email).downcase)
  end
end

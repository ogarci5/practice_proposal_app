# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest,  :password, :password_confirmation
  
  has_secure_password
  
  validates :email, uniqueness: true
  
  before_save do 
    email.downcase!
  end
  
  before_save :create_remember_token
  has_many :proposals, dependent: :destroy
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

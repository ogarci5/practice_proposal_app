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
#  username        :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :username, :name, :password_digest,  
                    :password, :password_confirmation
  has_secure_password
  
  has_and_belongs_to_many :roles
  belongs_to :request_group
  validates :name, presence:   true, length: { minimum: 3, maximum: 50 }

  validates :username, presence:   true, uniqueness: true, 
                    length: { minimum: 3, maximum: 50 }
                    
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: true, 
                    uniqueness: { case_sensitive: false}
  
  before_save do 
    email.downcase!
  end
  
  before_save :create_remember_token
  has_many :proposals, dependent: :destroy
  
  has_many :responses
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

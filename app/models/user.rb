class User < ActiveRecord::Base
  attr_accessible :email, :name,  :password, :password_confirmation
  
  has_secure_password
  
  before_save do 
    email.downcase!
  end
  before_save :create_remember_token
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

class User < ActiveRecord::Base
  attr_accessible :email, :name, :remember_token
end

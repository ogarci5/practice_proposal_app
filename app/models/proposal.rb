class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :response, :description, :from, :name
end

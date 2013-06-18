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
#
# Table name: proposals
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text
#  from          :string(255)
#  user_id       :integer
#  response      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  response_read :boolean          default(FALSE)
#  reviewed      :boolean          default(FALSE)
#

FactoryGirl.define do
  
  factory :user do
    name              "Michael Hartl"
    email             "michael@example.com"
    username          "mhartl"
    password          "123456"
  end
  
  factory :user2 do
    name              "John Doe"
    email             "John@Doe.com"
    username          "jdoe"
    password          "123456"
  end
  
  factory :proposal do
    name              "This is a sample"
    description       "Description: I would like to lower the price to $1.00"
    from              "joe"
    user_id           1
    response          "Here is your response"
    #response_read     false
    #reviewed          true 
  end
end



FactoryGirl.define do
  
  factory :user do
    name              "Michael Hartl"
    email             "michael@example.com"
    username          "mhartl"
    password          "123456"
  end
  
  factory :proposal do
    name              "This is a sample"
    description       "Test Description: I would like to lower the price to $1.00"
    user_id           1
  end
  
  
  factory :response do
    body              "This is the test response body"
    proposal_id       nil
    user_id           nil
    read              false
  end
end

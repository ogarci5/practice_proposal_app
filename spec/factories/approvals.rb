# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :approval do
    name "MyString"
    status "MyString"
    comment "MyText"
    user nil
  end
end

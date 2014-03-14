# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    user_id 1
    email "MyString"
    active false
    membership_code "MyString"
  end
end

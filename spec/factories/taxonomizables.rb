# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taxonomizable do
    item_id 1
    item_type "MyString"
    term_id 1
  end
end

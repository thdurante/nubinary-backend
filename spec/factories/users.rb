FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@sample.com" }
    password { 'complex_password' }
  end
end

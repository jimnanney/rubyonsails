FactoryGirl.define do
  factory :user do
    name                  "Test User"
    email                 "TestUser@example.com"
    password              "foobarbaz"
    password_confirmation "foobarbaz"
  end
end


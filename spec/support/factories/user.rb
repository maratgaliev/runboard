FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@test.com"}
    sequence(:login) {|n| "login#{n}"}
    sequence(:phone) {|n| "8903322112#{n}"}
    password 'password'
    bio 'bio'
    position 'position'
    name 'name'
  end
end

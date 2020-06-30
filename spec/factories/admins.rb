FactoryBot.define do
  factory :admin do
    name { "John Doe" }
    email { "john@doe.cl" }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
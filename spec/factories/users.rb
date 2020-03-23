FactoryBot.define do
  factory :user do
    email { "user#{id}@example.com" }
    password { "user#{id} password" }
  end
end

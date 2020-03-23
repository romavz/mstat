FactoryBot.define do
  factory :message do
    user
    text { "some Text" }
  end
end

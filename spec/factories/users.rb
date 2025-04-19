FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "vtactics#{n}@example.com" }
    password { "Q7zC4HFb" }
    password_confirmation { "Q7zC4HFb" }
    created_at { Time.current }
    updated_at { Time.current }
  end
end

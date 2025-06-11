FactoryBot.define do
  factory :technique do
    sequence(:title) { |n| "technique#{n}" }
    source_type { "youtube" }
    source_url { "https://youtu.be/dFtDrUKDwUM?si=IKWNHuWbJQKEnN8W" }
    video_timestamp { "1:25" }
    created_at { Time.current }
    updated_at { Time.current }
    association :user
  end
end

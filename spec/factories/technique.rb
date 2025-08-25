FactoryBot.define do
  factory :technique do
    sequence(:title) { |n| "technique#{n}" }
    source_url { "https://youtu.be/oUUoFnbZBy0?si=vXaKIXandzTZgSvK" }
    video_timestamp { "1:25" }
    created_at { Time.current }
    updated_at { Time.current }
    association :user
    # traitを使用することでletで生成する時に条件分岐が簡単にできる。
    trait :youtube do
      source_type { :youtube }
      source_url { "https://www.youtube.com/watch?v=#{SecureRandom.alphanumeric(11)}" }
    end

    trait :twitter do
      source_type { :twitter }
      sequence(:source_url) { |n| "https://x.com/user/status/#{n}" }
    end
  end
end

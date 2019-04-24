# frozen_string_literal: true

FactoryBot.define do
  factory :entry, class: "Archangel::Entry" do
    collection
    value { ActiveSupport::JSON.encode(title: "Title", content: "Content") }
    published_at { Time.current }

    trait :deleted do
      deleted_at { Time.current }
    end

    trait :unpublished do
      published_at { nil }
    end

    trait :future do
      published_at { 1.week.from_now }
    end
  end
end

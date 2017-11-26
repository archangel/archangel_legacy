# frozen_string_literal: true

FactoryBot.define do
  factory :entry, class: "Archangel::Entry" do
    collection
    value { ActiveSupport::JSON.encode(title: "Title", content: "Content") }
    available_at { Time.current }

    trait :deleted do
      deleted_at { Time.current }
    end

    trait :unavailable do
      deleted_at nil
    end
  end
end

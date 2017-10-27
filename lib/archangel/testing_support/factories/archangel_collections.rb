# frozen_string_literal: true

FactoryBot.define do
  factory :collection, class: "Archangel::Collection" do
    sequence(:name) { |n| "Collection #{n}" }
    sequence(:slug) { |n| "collection-#{n}" }

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

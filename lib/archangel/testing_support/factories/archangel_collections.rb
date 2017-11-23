# frozen_string_literal: true

FactoryBot.define do
  factory :collection, class: "Archangel::Collection" do
    site
    sequence(:name) { |n| "Collection #{n}" }
    sequence(:slug) { |n| "collection-#{n}" }

    trait :deleted do
      deleted_at { Time.current }
    end

    trait :with_fields do
      transient do
        fields_count 3
      end

      after(:create) do |collection, evaluator|
        create_list(:field, evaluator.fields_count, collection: collection)
      end
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :entry, class: "Archangel::Entry" do
    collection
    field
    value "Value of entry"

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

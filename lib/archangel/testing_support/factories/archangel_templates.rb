# frozen_string_literal: true

FactoryBot.define do
  factory :template, class: "Archangel::Template" do
    site
    sequence(:name) { |n| "Template #{n} Name" }
    content "<p>This is the content of the template.<p>"
    partial false

    trait :partial do
      partial true
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

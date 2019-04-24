# frozen_string_literal: true

FactoryBot.define do
  factory :page, class: "Archangel::Page" do
    site
    design { nil }
    sequence(:title) { |n| "Page #{n} Title" }
    sequence(:slug) { |n| "page-#{n}" }
    content { "<p>Content of the page</p>" }
    homepage { false }
    published_at { Time.current }

    trait :with_parent do
      association :parent, factory: :page
    end

    trait :with_design do
      association :design, factory: :design, partial: false
    end

    trait :homepage do
      homepage { true }
    end

    trait :unpublished do
      published_at { nil }
    end

    trait :future do
      published_at { 1.week.from_now }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

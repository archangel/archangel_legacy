# frozen_string_literal: true

FactoryGirl.define do
  factory :page, class: "Archangel::Page" do
    sequence(:title) { |n| "Page #{n} Title" }
    sequence(:slug) { |n| "page-#{n}" }
    content "<p>Content of the page</p>"
    meta_keywords "default,keywords,of,my,page"
    meta_description "Default description of my page"
    homepage false
    published_at { Time.current }

    trait :with_parent do
      association :parent, factory: :page
    end

    trait :with_template do
      association :template, factory: :template, partial: false
    end

    trait :homepage do
      homepage true
    end

    trait :unpublished do
      published_at nil
    end

    trait :future do
      published_at { 1.week.from_now }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

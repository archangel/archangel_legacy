# frozen_string_literal: true

FactoryBot.define do
  factory :widget, class: "Archangel::Widget" do
    site
    sequence(:name) { |n| "Widget #{n}" }
    sequence(:slug) { |n| "widget-#{n}" }
    content "<p>Content of the widget</p>"
    template_id 1

    trait :with_template do
      association :template, factory: :template, partial: true
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

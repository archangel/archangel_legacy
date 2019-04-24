# frozen_string_literal: true

FactoryBot.define do
  factory :design, class: "Archangel::Design" do
    site
    sequence(:name) { |n| "Design #{n} Name" }
    content do
      "<p>BEFORE DESIGN<p>
       <p>{{ content_for_layout }}<p>
       <p>AFTER DESIGN<p>"
    end
    partial { false }

    trait :partial do
      partial { true }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

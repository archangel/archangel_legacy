# frozen_string_literal: true

FactoryGirl.define do
  factory :template, class: "Archangel::Template" do
    sequence(:name) { |n| "Template #{n} Name" }
    content "<p>This is the content of the template.<p>"
    partial false

    trait :child do
      before(:create) do |tpl|
        parent = create(:template)

        tpl.parent_id = parent.id
      end
    end

    trait :partial do
      partial true
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

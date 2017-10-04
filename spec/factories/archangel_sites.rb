# frozen_string_literal: true

FactoryGirl.define do
  factory :site, class: "Archangel::Site" do
    sequence(:name) { |n| "Site #{n} Name" }
    locale "en"
    meta_keywords "default,keywords,of,my,site"
    meta_description "Default description of my site"

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

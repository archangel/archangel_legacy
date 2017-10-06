# frozen_string_literal: true

FactoryGirl.define do
  factory :asset, class: "Archangel::Asset" do
    sequence(:file_name) { |n| "image-#{n}.jpg" }
    file { fixture_file_upload(uploader_test_image) }
    content_type "image/jpg"
    file_size 123

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

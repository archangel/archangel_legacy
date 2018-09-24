# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: "Archangel::User" do
    site
    sequence(:name) { |n| "User #{n}" }
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    sequence(:confirmation_token) { |n| "token-#{n}" }
    confirmed_at { Time.current }
    confirmation_sent_at { Time.current }

    trait :avatar do
      avatar { fixture_file_upload(uploader_test_image) }
    end

    trait :admin do
      role { "admin" }
    end

    trait :editor do
      role { "editor" }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :reset do
      reset_password_token { "abc123" }
      reset_password_sent_at { Time.current }
    end

    trait :locked do
      failed_attempts { 10 }
      unlock_token { "123abc" }
      locked_at { Time.current }
    end

    trait :tracks do
      sign_in_count { 2 }
      current_sign_in_at { Time.current }
      last_sign_in_at { 1.day.ago }
      current_sign_in_ip { "127.0.0.1" }
      last_sign_in_ip { "127.0.0.1" }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end

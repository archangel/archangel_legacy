# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe User, type: :model do
    subject(:resource) { described_class.new }

    context "with validations" do
      let(:allowed_emails) do
        [
          "foo@example.com",
          "foo.bar@example.com",
          "foo_bar@example.com",
          "foo+bar@example.com",
          "~!\#$%^&*_+{}|\?`-='@example.com"
        ]
      end
      let(:not_allowed_emails) do
        [
          nil,
          "",
          "@",
          "foo@",
          "@example",
          "@example.com",
          "foo bar@example.com"
        ]
      end

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:role) }
      it { is_expected.to validate_presence_of(:username) }

      it "has a unique username scoped to Site" do
        resource = build(:user)

        expect(resource).to(
          validate_uniqueness_of(:username).scoped_to(:site_id).case_insensitive
        )
      end

      it "allows certain roles" do
        expect(resource)
          .to validate_inclusion_of(:role).in_array(Archangel::ROLES)
      end

      it "allows values for email" do
        allowed_emails.each do |email|
          expect(resource).to allow_value(email).for(:email)
        end
      end

      it "does not allows values for email" do
        not_allowed_emails.each do |email|
          expect(resource).not_to allow_value(email).for(:email)
        end
      end
    end

    context "with #to_param" do
      it "uses `slug` as the identifier for routes" do
        resource = build(:user, username: "foo")

        expect(resource.to_param).to eq("foo")
      end
    end

    context "with #column_reset" do
      it "resets `slug` to `slug` + current time" do
        resource = create(:user)

        username = resource.username

        resource.destroy!

        expect(resource.username).to eq "#{Time.current.to_i}_#{username}"
      end
    end
  end
end

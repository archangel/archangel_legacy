# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe User, type: :model do
    context "callbacks" do
      let(:resource) { create(:user) }

      it do
        expect(resource).to callback(:parameterize_username).before(:validation)
      end

      it { expect(resource).to callback(:column_default).after(:initialize) }
      it { expect(resource).to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { expect(subject).to validate_presence_of(:email) }
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:password).on(:create) }
      it { expect(subject).to validate_presence_of(:role) }
      it { expect(subject).to validate_presence_of(:username) }

      it { expect(subject).to validate_length_of(:password).is_at_least(8) }

      it { expect(subject).to have_db_index(:email).unique(true) }
      it { expect(subject).to have_db_index(:username).unique(true) }

      it do
        expect(subject)
          .to validate_inclusion_of(:role).in_array(Archangel::ROLES)
      end

      it "allows values for email" do
        [
          "foo@example.com",
          "foo.bar@example.com",
          "foo_bar@example.com",
          "foo+bar@example.com",
          "~!\#$%^&*_+{}|\?`-='@example.com"
        ].each do |email|
          expect(subject).to allow_value(email).for(:email)
        end
      end

      it "does not allows values for email" do
        [
          nil,
          "",
          "@",
          "foo@",
          "@example",
          "@example.com",
          "foo bar@example.com"
        ].each do |email|
          expect(subject).to_not allow_value(email).for(:email)
        end
      end
    end

    context "associations" do
      it { expect(subject).to belong_to(:site) }
    end
  end
end

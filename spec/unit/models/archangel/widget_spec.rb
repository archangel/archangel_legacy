# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Widget, type: :model do
    subject(:resource) { described_class.new }

    context "with validations" do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:slug) }

      it { is_expected.to allow_value("{{ foo }}").for(:content) }
      it { is_expected.not_to allow_value("{{ foo }").for(:content) }

      it "has a unique slug scoped to Site" do
        resource = build(:widget)

        expect(resource)
          .to validate_uniqueness_of(:slug).scoped_to(:site_id).case_insensitive
      end
    end

    context "with #to_param" do
      it "uses `slug` as the identifier for routes" do
        resource = build(:widget, slug: "foo")

        expect(resource.to_param).to eq("foo")
      end
    end

    context "with #column_reset" do
      it "resets `slug` to `slug` + current time" do
        resource = create(:widget)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end

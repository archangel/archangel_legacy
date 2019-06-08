# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Site, type: :model do
    context "with validations" do
      it { is_expected.to validate_presence_of(:locale) }
      it { is_expected.to validate_presence_of(:name) }

      it { is_expected.to allow_value("").for(:theme) }

      it "allows certain languages" do
        expect(subject)
          .to validate_inclusion_of(:locale).in_array(Archangel::LANGUAGES)
      end

      it "allows certain languages" do
        expect(subject)
          .to validate_inclusion_of(:theme).in_array(Archangel.themes)
      end
    end

    it { is_expected.to have_many(:assets) }
    it { is_expected.to have_many(:collections) }
    it { is_expected.to have_many(:designs) }
    it { is_expected.to have_many(:metatags) }
    it { is_expected.to have_many(:pages) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:widgets) }

    it { is_expected.to have_many(:entries).through(:collections) }
    it { is_expected.to have_many(:fields).through(:collections) }

    context "with .current" do
      it "returns an existing object" do
        resource = create(:site, name: "My Awesome New Site")

        expect(described_class.current).to eq(resource)
        expect(described_class.current.name).to eq("My Awesome New Site")
      end

      it "returns a new object" do
        expect(described_class.current.name).to eq("Archangel")
      end
    end

    context "with #to_liquid" do
      it "returns a Liquid object" do
        resource = build(:site)

        expect(resource.to_liquid).to be_a(Archangel::Liquid::Drops::SiteDrop)
      end
    end
  end
end

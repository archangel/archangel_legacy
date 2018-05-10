# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Site, type: :model do
    context "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:name) }
    end

    context ".current" do
      it "returns an existing object" do
        resource = create(:site, name: "My Awesome New Site")

        expect(described_class.current).to eq(resource)
        expect(described_class.current.name).to eq("My Awesome New Site")
      end

      it "returns a new object" do
        expect(described_class.current.name).to eq("Archangel")
      end
    end

    context "#to_liquid" do
      it "returns a Liquid object" do
        resource = build(:site)

        expect(resource.to_liquid).to be_a(Archangel::Liquid::Drops::SiteDrop)
      end
    end
  end
end

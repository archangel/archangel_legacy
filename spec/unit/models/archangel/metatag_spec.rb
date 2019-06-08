# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Metatag, type: :model do
    context "with validations" do
      it "has a unique name scoped to metatagable_type and metatagable_id" do
        resource = build(:metatag)

        expect(resource).to(
          validate_uniqueness_of(:name)
            .scoped_to(:metatagable_type, :metatagable_id)
        )
      end
    end

    context "with associations" do
      it { is_expected.to belong_to(:metatagable) }
    end
  end
end

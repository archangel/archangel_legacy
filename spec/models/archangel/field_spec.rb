# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Field, type: :model do
    context "validations" do
      it { is_expected.to validate_presence_of(:classification) }
      it { is_expected.to validate_presence_of(:collection_id).on(:update) }
      it { is_expected.to validate_presence_of(:label) }
      it { is_expected.to validate_presence_of(:slug) }

      it { is_expected.to allow_value(true).for(:required) }
      it { is_expected.to allow_value(1).for(:required) }
      it { is_expected.to allow_value(false).for(:required) }
      it { is_expected.to allow_value(0).for(:required) }

      it { is_expected.to_not allow_value(nil).for(:required) }

      it "allows certain classifications" do
        expect(subject).to(
          validate_inclusion_of(:classification)
            .in_array(Archangel::Field::CLASSIFICATIONS)
        )
      end

      it "has a unique slug scoped to Collection" do
        resource = build(:field)

        expect(resource).to(
          validate_uniqueness_of(:slug).scoped_to(:collection_id)
        )
      end
    end

    context "associations" do
      it { is_expected.to belong_to(:collection) }
    end
  end
end

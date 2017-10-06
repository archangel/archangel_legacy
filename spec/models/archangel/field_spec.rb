# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Field, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:classification) }
      it { expect(subject).to validate_presence_of(:collection_id) }
      it { expect(subject).to validate_presence_of(:label) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to allow_value(true).for(:required) }
      it { expect(subject).to allow_value(false).for(:required) }
      it { expect(subject).not_to allow_value(nil).for(:required) }

      it do
        expect(subject).to(
          validate_inclusion_of(:classification)
            .in_array(%w[string text boolean])
        )
      end
    end

    context "associations" do
      it { expect(subject).to belong_to(:collection) }
    end
  end
end

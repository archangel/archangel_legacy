# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Entry, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:collection_id) }
      it { expect(subject).to validate_presence_of(:value) }

      it { expect(subject).to allow_value(nil).for(:available_at) }
      it { expect(subject).to allow_value(Time.current).for(:available_at) }
      it { expect(subject).not_to allow_value("invalid").for(:available_at) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:collection) }
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Entry, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:collection_id) }
      it { expect(subject).to validate_presence_of(:field_id) }
      it { expect(subject).to validate_presence_of(:value) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:collection) }
      it { expect(subject).to belong_to(:field) }
    end
  end
end

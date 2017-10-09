# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Template, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:content) }
      it { expect(subject).to validate_presence_of(:name) }

      it { expect(subject).to allow_value(true).for(:partial) }
      it { expect(subject).to allow_value(false).for(:partial) }
      it { expect(subject).not_to allow_value(nil).for(:partial) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:parent) }
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Design, type: :model do
    subject(:resource) { described_class.new }

    context "with validations" do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:name) }

      it { is_expected.to allow_value(true).for(:partial) }
      it { is_expected.to allow_value(false).for(:partial) }

      it { is_expected.not_to allow_value(nil).for(:partial) }

      it { is_expected.to allow_value("{{ foo }}").for(:content) }
      it { is_expected.not_to allow_value("{{ foo }").for(:content) }
    end
  end
end

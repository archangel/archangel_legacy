# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Design, type: :model do
    context "with validations" do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:name) }

      it { is_expected.to allow_value(true).for(:partial) }
      it { is_expected.to allow_value(false).for(:partial) }

      it { is_expected.not_to allow_value(nil).for(:partial) }

      it { is_expected.to allow_value("{{ foo }}").for(:content) }
      it { is_expected.not_to allow_value("{{ foo }").for(:content) }
    end

    context "with associations" do
      it { is_expected.to belong_to(:site) }

      it "belongs to Design" do
        expect(subject).to(
          belong_to(:parent).conditions(partial: false)
                            .class_name("Archangel::Design")
                            .optional
        )
      end
    end
  end
end

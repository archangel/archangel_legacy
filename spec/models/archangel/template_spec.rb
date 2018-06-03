# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Template, type: :model do
    context "validations" do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:name) }

      it { is_expected.to allow_value(true).for(:partial) }
      it { is_expected.to allow_value(false).for(:partial) }

      it { is_expected.to_not allow_value(nil).for(:partial) }

      it { is_expected.to allow_value("{{ foo }}").for(:content) }
      it { is_expected.to_not allow_value("{{ foo }").for(:content) }
    end

    context "associations" do
      it { is_expected.to belong_to(:site) }

      it "belongs to Template" do
        expect(subject).to(
          belong_to(:parent).conditions(partial: false)
                            .class_name("Archangel::Template")
        )
      end
    end

    context "#status" do
      it "returns `partial` for partial Templates" do
        page = build(:template, :partial)

        expect(page.status).to eq("partial")
      end

      it "returns `full` for non-partial Templates" do
        page = build(:template)

        expect(page.status).to eq("full")
      end
    end
  end
end

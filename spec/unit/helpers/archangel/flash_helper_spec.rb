# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe FlashHelper, type: :helper do
    context "with #flash_class_for(obj)" do
      it "returns success class" do
        expect(helper.flash_class_for("success")).to eq("success")
      end

      it "returns `error` class" do
        expect(helper.flash_class_for("error")).to eq("danger")
      end

      it "returns `alert` class" do
        expect(helper.flash_class_for("alert")).to eq("warning")
      end

      it "returns `notice` class" do
        expect(helper.flash_class_for("notice")).to eq("info")
      end

      it "returns downcased for unknown class" do
        expect(helper.flash_class_for("Unknown")).to eq("unknown")
      end

      it "returns with dashes in place of spaces for class" do
        expect(helper.flash_class_for("foo  bar")).to eq("foo-bar")
      end

      it "returns with dashes in class" do
        expect(helper.flash_class_for("foo--bar")).to eq("foo-bar")
      end

      it "returns with underscores in class" do
        expect(helper.flash_class_for("foo_bar")).to eq("foo_bar")
      end
    end
  end
end

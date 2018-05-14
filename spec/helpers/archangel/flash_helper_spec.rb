# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe FlashHelper, type: :helper do
    context "#flash_class_for(obj)" do
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

      it "returns unknown class" do
        expect(helper.flash_class_for("unknown")).to eq("unknown")
        expect(helper.flash_class_for("foo bar")).to eq("foo-bar")
        expect(helper.flash_class_for("foo-bar")).to eq("foo-bar")
        expect(helper.flash_class_for("foo_bar")).to eq("foo_bar")
        expect(helper.flash_class_for("foo      bar")).to eq("foo-bar")
      end
    end
  end
end

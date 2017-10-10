# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe GlyphiconHelper, type: :helper do
    context "#glyphicon_icon" do
      it "builds default icon" do
        expect(helper.glyphicon_icon).to eq(
          '<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>'
        )
      end

      it "builds icon" do
        expect(helper.glyphicon_icon("user")).to eq(
          '<span class="glyphicon glyphicon-user" aria-hidden="true"></span>'
        )
      end

      it "builds icon with symbol icon name" do
        expect(helper.glyphicon_icon(:user)).to eq(
          '<span class="glyphicon glyphicon-user" aria-hidden="true"></span>'
        )
      end

      it "builds icon with text" do
        expect(helper.glyphicon_icon(:user, text: "User")).to eq(
          '<span class="glyphicon glyphicon-user" ' \
          'aria-hidden="true"></span> User'
        )
      end

      it "builds icon with additional classes" do
        expect(helper.glyphicon_icon(:user, class: "foo")).to eq(
          '<span class="glyphicon glyphicon-user foo" ' \
          'aria-hidden="true"></span>'
        )
      end

      it "builds icon with other attributes" do
        expect(helper.glyphicon_icon(:user, data: { id: 123 })).to eq(
          '<span data-id="123" class="glyphicon glyphicon-user" ' \
          'aria-hidden="true"></span>'
        )
      end
    end
  end
end

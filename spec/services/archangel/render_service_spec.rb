# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe RenderService, type: :service do
    context "#new" do
      it "builds the liquid content" do
        content = <<-LIQUID
          {% assign foo="bar" %}
          ~{{ foo }}~
          *{{ bat }}*
        LIQUID

        rendered = described_class.new(content, bat: "baz").call

        expect(rendered).to include("~bar~")
        expect(rendered).to include("*baz*")
      end
    end

    context ".call" do
      it "builds the liquid content" do
        content = <<-LIQUID
          {% assign foo="bar" %}
          ~{{ foo }}~
          *{{ bat }}*
        LIQUID

        rendered = described_class.call(content, bat: "baz")

        expect(rendered).to include("~bar~")
        expect(rendered).to include("*baz*")
      end
    end
  end
end

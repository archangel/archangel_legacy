# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe RenderService, type: :service do
    let(:render_content) do
      %(
        {% assign foo="bar" %}
        ~{{ foo }}~
        *{{ bat }}*
      )
    end

    context "with #new" do
      it "return liquid content with value for `foo`" do
        rendered = described_class.new(render_content).call

        expect(rendered).to include("~bar~")
      end

      it "return custom liquid content with value for `bat`" do
        rendered = described_class.new(render_content, bat: "baz").call

        expect(rendered).to include("*baz*")
      end
    end

    context "with .call" do
      it "return liquid content with value for `foo`" do
        rendered = described_class.call(render_content)

        expect(rendered).to include("~bar~")
      end

      it "return custom liquid content with value for `bat`" do
        rendered = described_class.call(render_content, bat: "baz")

        expect(rendered).to include("*baz*")
      end
    end
  end
end

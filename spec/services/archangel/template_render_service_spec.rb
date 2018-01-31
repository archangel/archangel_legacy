# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe TemplateRenderService, type: :service do
    context "#new" do
      it "builds the liquid content" do
        template = create(:template, content: "~{{ content_for_layout }}~")
        content = "<p>This is the content of the page</p>"

        rendered = described_class.new(template,
                                       content_for_layout: content).call

        expect(rendered).to include("~<p>This is the content of the page</p>~")
      end
    end

    context ".call" do
      it "builds the liquid content" do
        template = create(:template, content: "~{{ content_for_layout }}~")
        content = "<p>This is the content of the page</p>"

        rendered = described_class.call(template,
                                        content_for_layout: content)

        expect(rendered).to include("~<p>This is the content of the page</p>~")
      end
    end
  end
end

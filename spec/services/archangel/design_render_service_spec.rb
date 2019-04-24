# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe DesignRenderService, type: :service do
    context "#new" do
      it "builds the liquid content" do
        design = create(:design)
        content = "<p>This is the content of the page</p>"

        rendered = described_class.new(design,
                                       content_for_layout: content).call

        expect(rendered).to include("<p>This is the content of the page</p>")
      end
    end

    context ".call" do
      it "builds the liquid content" do
        design = create(:design)
        content = "<p>This is the content of the page</p>"

        rendered = described_class.call(design,
                                        content_for_layout: content)

        expect(rendered).to include("<p>This is the content of the page</p>")
      end

      it "builds the liquid content even without `{{ content_for_layout }}`" do
        design = create(:design, content: "FULL DESIGN")
        content = "<p>Content of the page is still rendered</p>"

        rendered = described_class.call(design,
                                        content_for_layout: content)

        expect(rendered)
          .to include("<p>Content of the page is still rendered</p>")
      end
    end
  end
end

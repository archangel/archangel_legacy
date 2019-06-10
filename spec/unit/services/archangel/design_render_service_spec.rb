# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe DesignRenderService, type: :service do
    context "with #new" do
      it "builds the liquid content" do
        design = create(:design)
        content = "<p>This is the content of the page</p>"

        rendered = described_class.new(design,
                                       content_for_layout: content).call

        expect(rendered).to include("<p>This is the content of the page</p>")
      end
    end

    context "with .call" do
      let(:design) { create(:design) }
      let(:design_blank) { create(:design, content: "<div>No content</div>") }
      let(:render_content) { "<p>This is the content of the page</p>" }

      it "builds the liquid content" do
        rendered = described_class.call(design,
                                        content_for_layout: render_content)

        expect(rendered).to include("<p>This is the content of the page</p>")
      end

      it "builds the liquid content even without `{{ content_for_layout }}`" do
        rendered = described_class.call(design_blank,
                                        content_for_layout: render_content)

        expect(rendered).to include("<p>This is the content of the page</p>")
      end

      it "builds Design layout without `{{ content_for_layout }}`" do
        rendered = described_class.call(design_blank,
                                        content_for_layout: render_content)

        expect(rendered).to include("<div>No content</div>")
      end
    end
  end
end

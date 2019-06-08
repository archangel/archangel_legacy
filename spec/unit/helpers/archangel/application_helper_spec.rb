# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe ApplicationHelper, type: :helper,
                                    disable: :verify_partial_doubles do
    before do
      allow(helper).to receive(:current_site).and_return(site)
    end

    let(:site) { create(:site) }

    context "with #frontend_resource_path" do
      it "returns the permalink with a string" do
        expect(helper.frontend_resource_path("foo/bar")).to eq("/foo/bar")
      end

      it "returns the permalink with a Page resource" do
        parent = create(:page, site: site, slug: "foo")
        page = create(:page, site: site, parent: parent, slug: "bar")

        expect(helper.frontend_resource_path(page)).to eq("/foo/bar")
      end
    end

    context "with #locale" do
      it "returns default application locale" do
        expect(helper.locale).to eq("en")
      end
    end

    context "with #text_direction" do
      it "returns default `ltr` text direction" do
        expect(helper.text_direction).to eq("ltr")
      end

      it "returns rtl text direction" do
        allow(helper).to receive(:text_direction).and_return("rtl")

        expect(helper.text_direction).to eq("rtl")
      end
    end
  end
end

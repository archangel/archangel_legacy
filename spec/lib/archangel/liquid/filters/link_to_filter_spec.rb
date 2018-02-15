# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Filters
      RSpec.describe LinkToFilter, type: :liquid_filter do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        def link_to(link_text, *args)
          link_to(args.first, link_text)
        end

        context "#link_to" do
          let(:link_text) { "Hello world!" }

          it "returns the link with no text provided" do
            content = "{{ '#{link_text}' | link_to }}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to eq(link_text)
          end

          it "returns the link with nil link provided" do
            link = nil
            content = "{{ '#{link_text}' | link_to: #{link} }}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to eq(link_text)
          end

          it "returns the link with empty link string provided" do
            link = ""
            content = "{{ '#{link_text}' | link_to: #{link} }}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to eq(link_text)
          end

          it "returns the link with URL" do
            link = "https://example.com"
            content = "{{ '#{link_text}' | link_to: '#{link}' }}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to eq("<a href=\"#{link}\">#{link_text}</a>")
          end

          it "returns the link with path" do
            link = "path/to/something"
            content = "{{ '#{link_text}' | link_to: '#{link}' }}"
            result = ::Liquid::Template.parse(content).render(context)

            expect(result).to eq("<a href=\"#{link}\">#{link_text}</a>")
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe GistTag, type: :liquid_tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = "{% gist %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns gist" do
          gist = "9bbaf7332bff1042c2d83fc88683b9df"
          result = ::Liquid::Template.parse("{% gist '#{gist}' %}")
                                     .render(context)

          expect(result).to include("https://gist.github.com/#{gist}.js")
        end

        it "returns gist with file" do
          gist = "9bbaf7332bff1042c2d83fc88683b9df"
          file = "hello.rb"
          content = "{% gist '#{gist}' file: '#{file}' %}"
          result = ::Liquid::Template.parse(content).render(context)

          expect(result)
            .to include("https://gist.github.com/#{gist}.js?file=#{file}")
        end
      end
    end
  end
end

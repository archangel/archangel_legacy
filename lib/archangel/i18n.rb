# frozen_string_literal: true

require "i18n"
require "active_support/core_ext/array/extract_options"

module Archangel
  extend ActionView::Helpers::TranslationHelper
  extend ActionView::Helpers::TagHelper

  class << self
    ##
    # Translate
    #
    # Example
    #     # config/locales/en.yml
    #     en:
    #       archangel:
    #         hello: Hello
    #         foo:
    #           bar: Bar
    #
    #     Archangel.translate(:hello) #=> "Hello"
    #     Archangel.translate(:bar, scope: :foo) #=> "Bar"
    #     Archangel.t(:hello) #=> "Hello"
    #     Archangel.t(:bar, scope: :foo) #=> "Bar"
    #     I18n.t(:hello, scope: :archangel) #=> "Hello"
    #     I18n.translate(:hello, scope: :archangel) #=> "Hello"
    #
    # @param args [String,Array] translation paramaters
    # @return [String] the translated string
    #
    def translate(*args)
      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:archangel)
      args << options

      super(*args)
    end
    alias t translate
  end
end

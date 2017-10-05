# frozen_string_literal: true

require "i18n"
require "active_support/core_ext/array/extract_options"

module Archangel
  extend ActionView::Helpers::TranslationHelper

  class << self
    def translate(*args)
      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:archangel)
      args << options

      super(*args)
    end
    alias t translate
  end
end

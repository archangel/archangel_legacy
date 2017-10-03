# frozen_string_literal: true

require "responders"

require "archangel/engine"
require "archangel/version"

module Archangel
  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze
  THEME_DEFAULT = "default".to_s.freeze

  class << self
    def themes
      [Archangel::THEME_DEFAULT] + Archangel::THEMES
    end
  end
end

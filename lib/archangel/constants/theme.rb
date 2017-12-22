# frozen_string_literal: true

module Archangel
  ##
  # Theme directories constant
  #
  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze

  ##
  # Theme names constant
  #
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze

  ##
  # Default theme constant
  #
  THEME_DEFAULT = "default".freeze
end

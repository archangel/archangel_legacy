# frozen_string_literal: true

module Archangel
  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze
  THEME_DEFAULT = "default".freeze
end

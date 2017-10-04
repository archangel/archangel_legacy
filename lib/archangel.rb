# frozen_string_literal: true

require "devise"
require "devise_invitable"
require "jquery-rails"
require "kaminari"
require "paranoia"
require "responders"
require "sass-rails"
require "uglifier"
require "validates"

require "archangel/engine"
require "archangel/version"

module Archangel
  ROLES = %w[admin editor].freeze
  ROLE_DEFAULT = ROLES.last

  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze
  THEME_DEFAULT = "default".to_s.freeze

  class << self
    def themes
      [Archangel::THEME_DEFAULT] + Archangel::THEMES
    end
  end
end

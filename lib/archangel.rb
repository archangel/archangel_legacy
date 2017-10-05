# frozen_string_literal: true

require "carrierwave"
require "devise"
require "devise_invitable"
require "file_validators"
require "jquery-rails"
require "kaminari"
require "mini_magick"
require "paranoia"
require "pundit"
require "responders"
require "sass-rails"
require "simple_form"
require "uglifier"
require "validates"

require "archangel/engine"
require "archangel/i18n"
require "archangel/version"

module Archangel
  LANGUAGES = %w[en].freeze
  LANGUAGE_DEFAULT = LANGUAGES.first
  RTL_LANGUAGES = [].freeze

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

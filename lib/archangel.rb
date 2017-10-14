# frozen_string_literal: true

require "acts_as_list"
require "acts_as_tree"
require "anyway_config"
require "bootstrap-sass"
require "bootstrap3-datetimepicker-rails"
require "carrierwave"
require "date_validator"
require "devise"
require "devise_invitable"
require "file_validators"
require "jquery-rails"
require "kaminari"
require "mini_magick"
require "momentjs-rails"
require "paranoia"
require "pundit"
require "responders"
require "sass-rails"
require "selectize-rails"
require "simple_form"
require "summernote-rails"
require "uglifier"
require "validates"

require "archangel/engine"
require "archangel/config"
require "archangel/i18n"
require "archangel/theme/themable_controller"
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
    def config
      @config ||= Config.new
    end
    alias configuration config

    def themes
      [THEME_DEFAULT] + THEMES
    end
  end
end

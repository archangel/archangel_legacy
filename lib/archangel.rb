# frozen_string_literal: true

require "acts_as_list"
require "acts_as_tree"
require "anyway_config"
require "bootstrap-sass"
require "bootstrap3-datetimepicker-rails"
require "carrierwave"
require "cocoon"
require "date_validator"
require "devise"
require "devise_invitable"
require "file_validators"
require "jbuilder"
require "jquery-rails"
require "kaminari"
require "liquid"
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
require "archangel/liquid/collection_drop"
require "archangel/liquid/drop"
require "archangel/liquid/renderer"
require "archangel/liquid/drops/page_drop"
require "archangel/liquid/drops/site_drop"
require "archangel/liquid/tags/csrf_meta_tags_tag"
require "archangel/theme/themable_controller"
require "archangel/version"

module Archangel
  LANGUAGES = %w[en].freeze
  LANGUAGE_DEFAULT = LANGUAGES.first.freeze

  ROLES = %w[admin editor].freeze
  ROLE_DEFAULT = ROLES.last.freeze

  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze
  THEME_DEFAULT = "default".freeze

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

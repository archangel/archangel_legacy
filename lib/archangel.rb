# frozen_string_literal: true

require "acts_as_list"
require "acts_as_tree"
require "anyway_config"
require "bootstrap"
require "bootstrap3-datetimepicker-rails"
require "carrierwave"
require "cocoon"
require "date_validator"
require "devise"
require "devise_invitable"
require "file_validators"
require "font-awesome-rails"
require "jbuilder"
require "jquery-rails"
require "kaminari"
require "liquid"
require "meta-tags"
require "mini_magick"
require "momentjs-rails"
require "paranoia"
require "popper_js"
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
require "archangel/liquid_view"
require "archangel/constants/language"
require "archangel/constants/role"
require "archangel/constants/theme"
require "archangel/liquid/drop"
require "archangel/liquid/drops/page_drop"
require "archangel/liquid/drops/site_drop"
require "archangel/liquid/filters/link_to_filter"
require "archangel/liquid/tags/application_tag"
require "archangel/liquid/tags/asset_tag"
require "archangel/liquid/tags/collection_tag"
require "archangel/liquid/tags/collectionfor_tag"
require "archangel/liquid/tags/csrf_meta_tags_tag"
require "archangel/liquid/tags/locale_tag"
require "archangel/liquid/tags/meta_tags_tag"
require "archangel/liquid/tags/text_direction_tag"
require "archangel/liquid/tags/theme_javascript_tag"
require "archangel/liquid/tags/theme_stylesheet_tag"
require "archangel/liquid/tags/vimeo_tag"
require "archangel/liquid/tags/youtube_tag"
require "archangel/liquid/tags/widget_tag"
require "archangel/theme/themable_controller"
require "archangel/version"

##
# Archangel
#
# @author dfreerksen
#
module Archangel
  class << self
    ##
    # Application configurations
    #
    # Example
    #     Archangel.config.backend_path #=> "backend"
    #     Archangel.config[:backend_path] #=> "backend"
    #     Archangel.config["backend_path"] #=> "backend"
    #
    # @return [Object] application configurations
    def config
      @config ||= Config.new
    end
    alias configuration config

    ##
    # Available themes
    #
    # Example
    #     Archangel.themes #=> ["default"]
    #     Archangel.themes #=> ["default", "my_theme"]
    #
    # @return [Array] available themes
    def themes
      [THEME_DEFAULT] + THEMES
    end

    ##
    # Archangel version
    #
    # @return [String] current version
    def version
      VERSION
    end
  end
end

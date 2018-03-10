# frozen_string_literal: true

module Archangel
  ##
  # Archangel themes
  #
  module Theme
    ##
    # Apply Archangel theme to page
    #
    class ThemableController
      ##
      # Theme name
      #
      attr_reader :theme_name

      class << self
        ##
        # Apply theme
        #
        # @param controller_class [Class] the controller
        # @param theme [String] the theme
        # @param options [Hash] the theme options
        #
        def apply_theme(controller_class, theme, options = {})
          filter_method = before_filter_method(options)
          options = options.slice(:only, :except)

          controller_class.class_eval do
            define_method :layout_from_theme do
              theme_instance.theme_name
            end

            define_method :theme_instance do
              @theme_instance ||=
                Archangel::Theme::ThemableController.new(self, theme)
            end

            define_method :current_theme do
              theme_instance.theme_name
            end

            private :layout_from_theme,
                    :theme_instance

            layout :layout_from_theme, options

            helper_method :current_theme
          end

          controller_class.send(filter_method, options) do |controller|
            controller.prepend_view_path theme_instance.theme_view_path
          end
        end

        private

        def before_filter_method(options)
          options.delete(:prepend) ? :prepend_before_action : :before_action
        end
      end

      ##
      # Theme initializer
      #
      # @param controller [Object] the controller
      # @param theme [String] the theme
      #
      def initialize(controller, theme)
        @controller = controller
        @theme_name = theme_name_identifier(theme)
      end

      ##
      # Archangel theme path
      #
      # @return [String] the path to the theme
      #
      def theme_view_path
        path = Rails.root
        path = Archangel::Engine.root if @theme_name == Archangel::THEME_DEFAULT

        "#{path}/app/themes/#{@theme_name}/views"
      end

      private

      def theme_name_identifier(theme)
        @controller.send(theme).to_s
      end
    end
  end
end

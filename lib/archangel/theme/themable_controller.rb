# frozen_string_literal: true

module Archangel
  module Theme
    class ThemableController
      attr_reader :theme_name

      class << self
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

            private :layout_from_theme, :theme_instance

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

      def initialize(controller, theme)
        @controller = controller
        @theme_name = theme_name_identifier(theme)
      end

      def theme_view_path
        path = @theme_name == "default" ? Archangel::Engine.root : Rails.root

        "#{path}/app/themes/#{@theme_name}/views"
      end

      private

      def theme_name_identifier(theme)
        @controller.send(theme).to_s
      end
    end
  end
end

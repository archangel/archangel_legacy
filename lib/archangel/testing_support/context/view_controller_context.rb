# frozen_string_literal: true

module Archangel
  module TestingSupport
    module ViewControllerContext
      extend ActiveSupport::Concern

      def setup_view_and_controller
        @view                 = ActionView::Base.new
        @controller           = ActionController::Base.new
        @request              = ActionDispatch::TestRequest.new(
          "PATH_INFO" => "/"
        )
        @response             = ActionDispatch::TestResponse.new

        @response.request     = @request
        @controller.request   = @request
        @controller.response  = @response
        @controller.params    = {}

        @view.assign_controller(@controller)
        @view.class.send(:include, @controller._helpers)
        @view.class.send(:include, ::Rails.application.routes.url_helpers)
      end

      def view
        @view
      end

      def controller
        @controller
      end

      def context(assigns = {})
        options = {
          helper: @view,
          view: @view,
          controller: @controller
        }

        @context ||= ::Liquid::Context.new(assigns, {}, options)
      end

      def expect_template_result(template, expected, assigns = {})
        assigns.each { |key, value| context[key] = value }

        actual = ::Liquid::Template.parse(template).render!(context)
        expect(actual.to_s.strip).to eq(expected.to_s.strip)
      end
    end
  end
end

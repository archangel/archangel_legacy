# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # Ajax helpers for feature testing
    #
    module AjaxHelpers
      def wait_for_ajax(timeout = Capybara.default_max_wait_time)
        Timeout.timeout(timeout) do
          loop until finished_all_ajax_requests?
        end
      end

      protected

      def finished_all_ajax_requests?
        page.evaluate_script("jQuery.active").zero?
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::AjaxHelpers, type: :feature,
                                                         js: true
end

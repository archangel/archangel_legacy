# frozen_string_literal: true

module Archangel
  class FrontendController < ApplicationController
    protected

    def per_page_default
      12
    end
  end
end

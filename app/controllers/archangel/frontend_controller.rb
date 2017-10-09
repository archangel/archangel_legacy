# frozen_string_literal: true

module Archangel
  class FrontendController < ApplicationController
    protected

    def load_site_layout
      "archangel/layouts/frontend"
    end
  end
end

# frozen_string_literal: true

module Archangel
  ##
  # Frontend base controller
  #
  class FrontendController < ApplicationController
    include Archangel::SeoableConcern
  end
end

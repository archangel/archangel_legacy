# frozen_string_literal: true

module Archangel
  class BackendController < ApplicationController
    before_action :authenticate_user!
  end
end

# frozen_string_literal: true

module Archangel
  module PaginatableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :page_num, :per_page
    end

    def per_page
      params.fetch(:per, per_page_default)
    end

    def page_num
      params.fetch(Kaminari.config.param_name, 1)
    end

    protected

    def per_page_default
      Kaminari.config.default_per_page
    end
  end
end

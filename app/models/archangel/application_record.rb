# frozen_string_literal: true

module Archangel
  ##
  # Application base model
  #
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

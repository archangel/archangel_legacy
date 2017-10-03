# frozen_string_literal: true

module Archangel
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

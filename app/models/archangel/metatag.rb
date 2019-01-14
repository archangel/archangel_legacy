# frozen_string_literal: true

module Archangel
  ##
  # Metatag model
  #
  class Metatag < ApplicationRecord
    validates :name, uniqueness: { scope: %i[metatagable_type metatagable_id] }

    belongs_to :metatagable, polymorphic: true
  end
end

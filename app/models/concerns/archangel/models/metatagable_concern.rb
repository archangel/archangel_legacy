# frozen_string_literal: true

module Archangel
  ##
  # Model concerns
  #
  module Models
    ##
    # Model meta tag concern
    #
    module MetatagableConcern
      extend ActiveSupport::Concern

      included do
        has_many :metatags, as: :metatagable, dependent: :destroy

        accepts_nested_attributes_for :metatags, reject_if: :all_blank,
                                                 allow_destroy: true
      end
    end
  end
end

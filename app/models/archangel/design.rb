# frozen_string_literal: true

module Archangel
  ##
  # Design model
  #
  class Design < ApplicationRecord
    acts_as_paranoid

    validates :content, presence: true
    validates :name, presence: true
    validates :partial, inclusion: { in: [true, false] }

    validate :valid_liquid_content

    belongs_to :parent, -> { where(partial: false) },
               class_name: "Archangel::Design",
               inverse_of: false,
               optional: true
    belongs_to :site

    protected

    def valid_liquid_content
      return if valid_liquid_content?

      errors.add(:content, Archangel.t(:liquid_invalid))
    end

    def valid_liquid_content?
      ::Liquid::Template.parse(content)

      true
    rescue ::Liquid::SyntaxError
      false
    end
  end
end

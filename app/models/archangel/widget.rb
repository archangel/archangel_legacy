# frozen_string_literal: true

module Archangel
  ##
  # Widget model
  #
  class Widget < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    after_destroy :column_reset

    validates :content, presence: true
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: { scope: :site_id }

    validate :valid_liquid_content

    belongs_to :site
    belongs_to :template, -> { where(partial: true) }, optional: true

    ##
    # Overwrite resource id to `slug`
    #
    # @return [String] the aliased resource param
    #
    def to_param
      slug
    end

    protected

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def column_reset
      now = Time.current.to_i

      self.slug = "#{now}_#{slug}"

      save
    end

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

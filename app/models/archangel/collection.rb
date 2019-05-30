# frozen_string_literal: true

module Archangel
  ##
  # Collection model
  #
  class Collection < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    after_destroy :column_reset

    validates :name, presence: true
    validates :slug, presence: true, uniqueness: { scope: :site_id }

    belongs_to :site

    has_many :entries
    has_many :fields

    has_many :entries, inverse_of: :collection
    has_many :fields, inverse_of: :collection

    accepts_nested_attributes_for :fields, reject_if: :all_blank,
                                           allow_destroy: true

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
  end
end

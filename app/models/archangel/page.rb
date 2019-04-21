# frozen_string_literal: true

module Archangel
  ##
  # Page model
  #
  class Page < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :title
    acts_as_paranoid

    before_validation :parameterize_slug

    before_save :build_page_permalink

    after_save :homepage_reset

    after_destroy :column_reset

    validates :content, presence: true
    validates :homepage, inclusion: { in: [true, false] }
    validates :permalink, uniqueness: { scope: :site_id }
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true,
                     uniqueness: { scope: %i[parent_id site_id] }
    validates :title, presence: true

    validate :valid_liquid_content
    validate :within_valid_path

    belongs_to :design, -> { where(partial: false) }, optional: true
    belongs_to :parent, class_name: "Archangel::Page", optional: true
    belongs_to :site

    has_many :metatags, as: :metatagable

    accepts_nested_attributes_for :metatags, reject_if: :all_blank,
                                             allow_destroy: true

    scope :published, (lambda do
      where.not(published_at: nil).where("published_at <= ?", Time.now)
    end)

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    scope :homepage, (-> { where(homepage: true) })

    ##
    # Check if Page is published.
    #
    # Future publication date is also considered published. This will return
    # true if there is any published date avaialable; past and future.
    #
    # @see Page.available?
    #
    # @return [Boolean] if published
    #
    def published?
      published_at.present?
    end

    ##
    # Check if Page is currently available.
    #
    # This will return true if there is a published date and it is in the past.
    # Future publication date will return false.
    #
    # @return [Boolean] if available
    #
    def available?
      published? && published_at < Time.now
    end

    ##
    # Liquid object for Page
    #
    # @return [Object] the Liquid object
    #
    def to_liquid
      Archangel::Liquid::Drops::PageDrop.new(self)
    end

    protected

    def valid_liquid_content
      return if valid_liquid_content?

      errors.add(:content, Archangel.t(:liquid_invalid))
    end

    def within_valid_path
      return if within_valid_path?

      errors.add(:slug, Archangel.t(:restricted_path))
    end

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def build_page_permalink
      parent_permalink = parent.blank? ? nil : parent.permalink

      self.permalink = [parent_permalink, slug].compact.join("/")
    end

    def homepage_reset
      return unless homepage?

      self.class
          .where(homepage: true)
          .where.not(id: id)
          .update_all(homepage: false)
    end

    def column_reset
      self.slug = "#{Time.current.to_i}_#{slug}"

      save
    end

    def valid_liquid_content?
      ::Liquid::Template.parse(content)

      true
    rescue ::Liquid::SyntaxError => _e
      false
    end

    def within_valid_path?
      reserved_paths.reject(&:empty?).each do |path|
        return false if %r{^#{slug}/?}.match?(path)
      end
    end

    def reserved_paths
      Archangel.config.keys_in(Archangel.reserved_page_keywords).values
    end
  end
end

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

    before_save :build_page_path

    after_save :homepage_reset

    after_destroy :column_reset

    validates :content, presence: true
    validates :homepage, inclusion: { in: [true, false] }
    validates :path, uniqueness: { scope: :site_id }
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true, uniqueness: { scope: :parent_id }
    validates :title, presence: true

    validate :valid_liquid_content
    validate :within_valid_path

    belongs_to :parent, class_name: "Archangel::Page", optional: true
    belongs_to :site
    belongs_to :template, -> { where(partial: false) }, optional: true

    scope :published, (lambda do
      where.not(published_at: nil).where("published_at <= ?", Time.now)
    end)

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    scope :homepage, (-> { where(homepage: true) })

    ##
    # Check if Page is published. Published in the past, present and future.
    # Future publication date is also considered published.
    #
    # @return [Boolean] if published
    #
    def published?
      published_at.present?
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

    def build_page_path
      parent_path = parent.blank? ? nil : parent.path

      self.path = [parent_path, slug].compact.join("/")
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
      Archangel.config.to_h.select do |key, _val|
        %i[auth_path backend_path frontend_path].include?(key)
      end.values
    end
  end
end

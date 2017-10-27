# frozen_string_literal: true

module Archangel
  class Page < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :title
    acts_as_paranoid

    before_validation :parameterize_slug

    before_save :build_path_before_save

    after_save :homepage_reset

    after_destroy :column_reset

    validates :content, presence: true
    validates :homepage, inclusion: { in: [true, false] }
    validates :path, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true
    validates :title, presence: true

    validate :unique_slug_per_level

    belongs_to :parent, class_name: "Archangel::Page", optional: true
    belongs_to :template, -> { where(partial: false) }, optional: true

    scope :published, (lambda do
      where.not(published_at: nil).where("published_at <= ?", Time.now)
    end)

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    scope :homepage, (-> { where(homepage: true) })

    def published?
      published_at.present?
    end

    def to_liquid
      Archangel::Liquid::Drops::PageDrop.new(self)
    end

    protected

    def unique_slug_per_level
      return if unique_slug_per_level?

      errors.add(:slug, Archangel.t(:duplicate_slug))
    end

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def build_path_before_save
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

    def unique_slug_per_level?
      self.class
          .where(parent_id: parent_id, slug: slug)
          .where.not(id: id)
          .empty?
    end
  end
end

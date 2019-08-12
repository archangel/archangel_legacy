# frozen_string_literal: true

module Archangel
  ##
  # Page model
  #
  class Page < ApplicationRecord
    include Archangel::Models::MetatagableConcern
    include Archangel::Models::PublishableConcern

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
    validates :slug, presence: true,
                     uniqueness: { scope: %i[parent_id site_id] }
    validates :title, presence: true

    validate :valid_liquid_content
    validate :within_valid_path

    belongs_to :design, -> { where(partial: false) },
               inverse_of: false,
               optional: true
    belongs_to :parent, class_name: "Archangel::Page", optional: true
    belongs_to :site

    scope :homepage, (-> { where(homepage: true) })

    def content_compiled
      variables = {
        current_page: "/#{permalink}",
        page: to_liquid,
        site: site.to_liquid
      }

      Archangel::RenderService.call(content, variables)
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
    rescue ::Liquid::SyntaxError
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

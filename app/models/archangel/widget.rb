# frozen_string_literal: true

module Archangel
  class Widget < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    after_destroy :column_reset

    validates :content, presence: true
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true

    belongs_to :template, -> { where(partial: true) },
               class_name: "Archangel::Template",
               optional: true

    default_scope { order(name: :asc) }

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

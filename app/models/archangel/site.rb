# frozen_string_literal: true

module Archangel
  ##
  # Site model
  #
  class Site < ApplicationRecord
    acts_as_paranoid

    mount_uploader :favicon, Archangel::FaviconUploader
    mount_uploader :logo, Archangel::LogoUploader

    validates :favicon, file_size: {
      less_than_or_equal_to: Archangel.config.favicon_maximum_file_size
    }
    validates :locale, presence: true, inclusion: { in: Archangel::LANGUAGES }
    validates :logo, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
    validates :name, presence: true
    validates :theme, inclusion: { in: Archangel.themes }, allow_blank: true

    has_many :assets
    has_many :pages
    has_many :templates
    has_many :users
    has_many :widgets

    has_many :collections
    has_many :entries, through: :collections

    ##
    # Current site
    #
    # @return [Object] first availabe site as current site
    #
    def self.current
      first_or_create do |site|
        site.name = "Archangel"
      end
    end

    ##
    # Liquid object for Site
    #
    # @return [Object] the Liquid object
    #
    def to_liquid
      Archangel::Liquid::Drops::SiteDrop.new(self)
    end
  end
end

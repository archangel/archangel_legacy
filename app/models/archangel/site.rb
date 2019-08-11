# frozen_string_literal: true

module Archangel
  ##
  # Site model
  #
  class Site < ApplicationRecord
    include Archangel::Models::MetatagableConcern

    acts_as_paranoid

    mount_uploader :logo, Archangel::LogoUploader

    typed_store :settings, coder: JSON do |setting|
      setting.boolean :allow_registration, default: false
      setting.boolean :homepage_redirect, default: false
      setting.datetime :preferred_at, default: Time.current, accessor: false
    end

    validates :locale, presence: true, inclusion: { in: Archangel::LANGUAGES }
    validates :logo, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
    validates :name, presence: true
    validates :theme, inclusion: { in: Archangel.themes }, allow_blank: true

    validates :allow_registration, inclusion: { in: [true, false] }
    validates :homepage_redirect, inclusion: { in: [true, false] }

    has_many :assets, dependent: :destroy
    has_many :collections, dependent: :destroy
    has_many :designs, dependent: :destroy
    has_many :pages, dependent: :destroy
    has_many :users, dependent: :destroy
    has_many :widgets, dependent: :destroy

    has_many :entries, through: :collections
    has_many :fields, through: :collections

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

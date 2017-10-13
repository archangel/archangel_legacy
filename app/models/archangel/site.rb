# frozen_string_literal: true

module Archangel
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
    validates :theme, presence: true,
                      inclusion: { in: Archangel.themes },
                      allow_blank: true

    def self.current
      first_or_create do |site|
        site.name = "Archangel"
      end
    end
  end
end

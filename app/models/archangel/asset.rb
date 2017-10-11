# frozen_string_literal: true

module Archangel
  class Asset < ApplicationRecord
    acts_as_paranoid

    mount_uploader :file, Archangel::AssetUploader

    before_save :save_asset_attributes

    validates :file, presence: true,
                     file_size: {
                       less_than_or_equal_to:
                         Archangel.config.asset_maximum_file_size
                     }
    validates :file_name, presence: true

    validate :valid_file_name

    default_scope { order(file_name: :asc) }

    protected

    def save_asset_attributes
      return unless file.present? && file_changed?

      asset_object = file.file

      self.content_type = asset_object.content_type
      self.file_size = asset_object.size
    end

    def valid_file_name
      return if /^[\w-]+\.[A-Za-z]{3}$/ =~ file_name

      errors.add(:file_name, Archangel.t(:file_name_invalid))
    end
  end
end

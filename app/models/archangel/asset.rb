# frozen_string_literal: true

module Archangel
  class Asset < ApplicationRecord
    acts_as_paranoid

    mount_uploader :file, Archangel::AssetUploader

    before_validation :parameterize_file_name

    before_save :save_asset_attributes

    validates :file, presence: true,
                     file_size: {
                       less_than_or_equal_to: 2.megabytes
                     }
    validates :file_name, presence: true

    default_scope { order(file_name: :asc) }

    protected

    def parameterize_file_name
      self.file_name = file_name.to_s.downcase.parameterize
    end

    def save_asset_attributes
      return unless file.present? && file_changed?

      asset_object = file.file

      self.content_type = asset_object.content_type
      self.file_size = asset_object.size
    end
  end
end

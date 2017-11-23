# frozen_string_literal: true

module Archangel
  class Template < ApplicationRecord
    acts_as_paranoid

    validates :content, presence: true
    validates :name, presence: true
    validates :partial, inclusion: { in: [true, false] }

    belongs_to :parent, -> { where(partial: false) },
               class_name: "Archangel::Template",
               optional: true
    belongs_to :site 
  end
end

# frozen_string_literal: true

module Archangel
  class Template < ApplicationRecord
    acts_as_paranoid

    validates :content, presence: true
    validates :name, presence: true
    validates :partial, inclusion: { in: [true, false] }

    belongs_to :parent_template,
               class_name: "Archangel::Template",
               foreign_key: :parent_id,
               optional: true

    default_scope { order(name: :asc) }
  end
end

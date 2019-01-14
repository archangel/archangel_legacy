class RemoveMetaKeywordsAndMetaDescriptionFromArchangelPages < ActiveRecord::Migration[5.2]
  def change
    remove_column :archangel_pages, :meta_keywords, :string
    remove_column :archangel_pages, :meta_description, :string
  end
end

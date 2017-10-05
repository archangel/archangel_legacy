# This migration comes from archangel (originally 20171003191001)
class CreateArchangelSites < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_sites do |t|
      t.string :name, null: false, default: "Archangel"
      t.string :theme
      t.string :locale, null: false, default: "en"
      t.string :logo
      t.string :favicon
      t.string :meta_keywords
      t.string :meta_description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_sites, :deleted_at
    add_index :archangel_sites, :name
  end
end

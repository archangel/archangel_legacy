# This migration comes from archangel (originally 20171006194044)
class CreateArchangelCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_collections do |t|
      t.string :name
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_collections, :deleted_at
    add_index :archangel_collections, :name
    add_index :archangel_collections, :slug, unique: true
  end
end

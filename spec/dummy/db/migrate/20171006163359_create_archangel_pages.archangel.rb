# This migration comes from archangel (originally 20171005224054)
class CreateArchangelPages < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_pages do |t|
      t.integer :parent_id
      t.integer :template_id
      t.string :title
      t.string :slug
      t.string :path
      t.text :content, default: ""
      t.boolean :homepage, default: false
      t.string :meta_keywords
      t.string :meta_description
      t.datetime :published_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_pages, :deleted_at
    add_index :archangel_pages, :homepage
    add_index :archangel_pages, :parent_id
    add_index :archangel_pages, :path, unique: true
    add_index :archangel_pages, :published_at
    add_index :archangel_pages, :slug
    add_index :archangel_pages, :template_id
    add_index :archangel_pages, :title
  end
end

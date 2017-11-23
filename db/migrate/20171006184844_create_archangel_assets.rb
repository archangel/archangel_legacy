class CreateArchangelAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_assets do |t|
      t.integer :site_id, null: false
      t.string :file_name
      t.string :file
      t.string :content_type
      t.integer :file_size
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_assets, :deleted_at
    add_index :archangel_assets, :file_name, unique: true
    add_index :archangel_assets, :site_id
  end
end

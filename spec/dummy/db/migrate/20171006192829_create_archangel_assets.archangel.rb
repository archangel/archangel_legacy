# This migration comes from archangel (originally 20171006184844)
class CreateArchangelAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_assets do |t|
      t.string :file_name
      t.string :file
      t.string :content_type
      t.integer :file_size
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_assets, :deleted_at
    add_index :archangel_assets, :file_name, unique: true
  end
end

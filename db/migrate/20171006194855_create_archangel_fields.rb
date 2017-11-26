class CreateArchangelFields < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_fields do |t|
      t.integer :collection_id, null: false
      t.string :label
      t.string :slug
      t.string :value
      t.string :classification
      t.boolean :required
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_fields, :classification
    add_index :archangel_fields, :collection_id
    add_index :archangel_fields, :deleted_at
    add_index :archangel_fields, :label
    add_index :archangel_fields, :required
    add_index :archangel_fields, :slug
  end
end

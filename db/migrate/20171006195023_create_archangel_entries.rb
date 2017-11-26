class CreateArchangelEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_entries do |t|
      t.integer :collection_id, null: false
      t.text :value
      t.integer :position
      t.datetime :available_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_entries, :available_at
    add_index :archangel_entries, :collection_id
    add_index :archangel_entries, :deleted_at
    add_index :archangel_entries, :position
  end
end

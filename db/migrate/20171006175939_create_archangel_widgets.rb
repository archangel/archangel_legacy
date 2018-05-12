class CreateArchangelWidgets < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_widgets do |t|
      t.integer :site_id, null: false
      t.string :name
      t.string :slug
      t.text :content
      t.integer :template_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_widgets, :deleted_at
    add_index :archangel_widgets, :name
    add_index :archangel_widgets, :site_id
    add_index :archangel_widgets, :slug
    add_index :archangel_widgets, :template_id
  end
end

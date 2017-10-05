# This migration comes from archangel (originally 20171005205520)
class CreateArchangelTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :archangel_templates do |t|
      t.integer :parent_id
      t.string :name
      t.text :content
      t.boolean :partial
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_templates, :parent_id
    add_index :archangel_templates, :deleted_at
  end
end

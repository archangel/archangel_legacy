class CreateArchangelMetatags < ActiveRecord::Migration[5.2]
  def change
    create_table :archangel_metatags do |t|
      t.references :metatagable, polymorphic: true, index: false
      t.string :name
      t.string :content

      t.timestamps
    end

    add_index :archangel_metatags, [:metatagable_id, :metatagable_type],
              name: "index_archangel_metatags_on_metatagable_id_and_type"
  end
end

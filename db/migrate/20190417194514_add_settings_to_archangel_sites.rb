class AddSettingsToArchangelSites < ActiveRecord::Migration[5.2]
  def change
    add_column :archangel_sites, :settings, :text
  end
end

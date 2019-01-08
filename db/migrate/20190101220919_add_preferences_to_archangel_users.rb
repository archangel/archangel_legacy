class AddPreferencesToArchangelUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :archangel_users, :preferences, :text
  end
end

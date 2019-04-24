class RenameArchangelEntriesAvailableAtToPublishedAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :archangel_entries, :available_at, :published_at
  end
end

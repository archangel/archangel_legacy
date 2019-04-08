class RenameArchangelPagesPathToPermalink < ActiveRecord::Migration[5.2]
  def change
    rename_column :archangel_pages, :path, :permalink
  end
end

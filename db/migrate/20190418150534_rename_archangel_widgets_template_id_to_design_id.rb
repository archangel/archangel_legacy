class RenameArchangelWidgetsTemplateIdToDesignId < ActiveRecord::Migration[5.2]
  def change
    rename_column :archangel_widgets, :template_id, :design_id
  end
end

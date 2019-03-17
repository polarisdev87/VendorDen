class RenameTypeToStructureType < ActiveRecord::Migration[5.2]
  def change
  	rename_column :settings, :type, :structure_type
  end
end

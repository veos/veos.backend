class DropAllPhase1Tables < ActiveRecord::Migration
  def up
    drop_table :camera_spaces
    drop_table :cameras
    drop_table :photos
    drop_table :sign_stated_properties
    drop_table :sign_stated_purposes
    drop_table :signs
    drop_table :reports
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot revert back to phase 1 model after switching to phase 2."
  end
end

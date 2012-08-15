class RemoveComplianceLevel < ActiveRecord::Migration
  def change
    remove_column :installations, :compliance_level
  end
end

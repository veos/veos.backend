class ChangeComplianceToString < ActiveRecord::Migration
  def change
    change_column :installations, :compliance_level_override, :string
  end
end

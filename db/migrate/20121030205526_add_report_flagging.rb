class AddReportFlagging < ActiveRecord::Migration
  def change
    add_column :reports, :flagged, :boolean
    add_column :reports, :flagged_on, :datetime
    add_column :reports, :flagged_by, :string
    add_column :reports, :flagged_reason, :text
  end
end

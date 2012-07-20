class RenameSignTagsToReportTags < ActiveRecord::Migration
  def change
    rename_table :sign_tags, :report_tags
  end
end

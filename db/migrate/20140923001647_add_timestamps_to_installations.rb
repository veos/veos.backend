class AddTimestampsToInstallations < ActiveRecord::Migration
  def change
    change_table :installations do |t|
      t.timestamps
    end
    change_table :organizations do |t|
      t.timestamps
    end
  end
end

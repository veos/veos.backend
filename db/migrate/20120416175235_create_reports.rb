class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :loc_lat_from_gps
      t.float :loc_lng_from_gps
      t.string :loc_description_from_google
      t.float :loc_lat_from_user
      t.float :loc_lng_from_user
      t.string :loc_description_from_user
      t.string :owner_name
      t.string :owner_description
      t.timestamps
    end
  end
end

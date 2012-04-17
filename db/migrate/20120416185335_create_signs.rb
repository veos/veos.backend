class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.belongs_to :report, :null => false

      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end

    add_foreign_key(:signs, :reports, :dependent => :delete)
  end
end

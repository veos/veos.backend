class CreateCameras < ActiveRecord::Migration
  def change
    create_table :cameras do |t|
      t.belongs_to :report, :null => false
      t.timestamps
    end

    add_foreign_key(:cameras, :reports, :dependent => :delete)
  end
end

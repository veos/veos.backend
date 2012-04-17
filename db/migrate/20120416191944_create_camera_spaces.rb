class CreateCameraSpaces < ActiveRecord::Migration
  def change
    create_table :camera_spaces do |t|
      t.belongs_to :camera
      t.string :space, :null => false
      t.timestamps
    end

    add_foreign_key(:camera_spaces, :cameras, :dependent => :delete)
  end
end

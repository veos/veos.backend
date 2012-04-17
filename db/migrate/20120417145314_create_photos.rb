class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :of_object, :polymorphic => true
      t.has_attached_file :image
      t.timestamps
    end
  end
end

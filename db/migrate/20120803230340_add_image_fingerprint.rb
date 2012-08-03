class AddImageFingerprint < ActiveRecord::Migration
  def change
    add_column :photos, :image_fingerprint, :string
  end
end

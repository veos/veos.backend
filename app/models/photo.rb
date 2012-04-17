class Photo < ActiveRecord::Base
  attr_protected :id

  belongs_to :object, :polymorphic => true
  has_attached_file :image, :path => ":rails_root/public/photos/:attachment/:id/:style/:filename.jpg"
end

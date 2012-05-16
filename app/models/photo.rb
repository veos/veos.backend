class Photo < ActiveRecord::Base
  attr_protected :id

  belongs_to :of_object, :polymorphic => true
  has_attached_file :image, 
    :path => ":rails_root/public/photos/:attachment/:id/:style/:filename.jpg",
    :url => "/photos/:attachment/:id/:style/:filename.jpg",
    :styles => { :thumb => "100x100#", :big => "700x700" }

  def url
    image.url
  end

  def thumb_url
    image.url(:thumb)
  end

  def big_url
    image.url(:big)
  end
end

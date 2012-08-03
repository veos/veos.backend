class Photo < ActiveRecord::Base
  attr_protected :id, 
    :url, :big_url, :thumb_url, 
    :created_at, :updated_at

  belongs_to :report
  has_many :tags, :class_name => PhotoTag.name

  accepts_nested_attributes_for :tags

  has_attached_file :image, 
    :path => ":rails_root/public/photos/:attachment/:fingerprint/:style/:filename.jpg",
    :url => "/photos/:attachment/:fingerprint/:style/:filename.jpg",
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

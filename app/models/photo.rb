class Photo < ActiveRecord::Base
  attr_protected :id, 
    :url, :big_url, :thumb_url, :big_thumb_url,
    :created_at, :updated_at

  belongs_to :report
  has_many :tags, :class_name => PhotoTag.name

  accepts_nested_attributes_for :tags, :allow_destroy => true

  has_attached_file :image, 
    :path => ":rails_root/public/photos/:attachment/:fingerprint/:style/:filename.jpg",
    :url => "/photos/:attachment/:fingerprint/:style/:filename.jpg",
    :styles => { :thumb => "100x100#", :big_thumb => "400x400#", :big => "720x720" },
    :convert_options => {
      :all => "-auto-orient"
    }

  def url
    image.url
  end

  def thumb_url
    image.url(:thumb)
  end

  def big_thumb_url
    image.url(:big_thumb)
  end

  def big_url
    image.url(:big)
  end
end

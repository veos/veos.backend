class Report < ActiveRecord::Base
  attr_protected :id, 
    :installation_attributes # hacky way to ignore installation stuff, since we don't want this updated via nested attributes

  belongs_to :installation
  has_many :photos
  has_many :sign_tags

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :sign_tags

  validates :loc_lat_from_gps, :loc_lng_from_gps, :presence => true,
    :if => Proc.new {|r| r.loc_lat_from_user.blank? && r.loc_lng_from_user.blank?}

  include GeoMixin

  def loc_lat
    loc_lat_from_user || loc_lat_from_gps
  end

  def loc_lng
    loc_lng_from_user || loc_lng_from_gps
  end

end

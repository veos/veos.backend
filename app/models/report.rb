class Report < ActiveRecord::Base
  attr_protected :id

  # note that current spec allows only camera OR sign, not both; 
  # but backend model currently actually allows both a camera and a sign
  has_one :camera
  has_one :sign

  accepts_nested_attributes_for :camera
  accepts_nested_attributes_for :sign

  validates_presence_of :loc_lat_from_gps, :loc_lng_from_gps
end

class Report < ActiveRecord::Base
  attr_protected :id

  # note that current spec allows only camera OR sign, not both; 
  # but backend model currently actually allows both a camera and a sign
  has_one :camera
  has_one :sign

  accepts_nested_attributes_for :camera
  accepts_nested_attributes_for :sign
end

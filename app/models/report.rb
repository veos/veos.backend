class Report < ActiveRecord::Base
  attr_protected :id

  # note that current spec allows only camera OR sign, not both; 
  # but backend model currently actually allows both a camera and a sign
  has_one :camera
  has_one :sign

  accepts_nested_attributes_for :camera
  accepts_nested_attributes_for :sign

  validates_associated :camera, :if => :camera
  validates_associated :sign, :if => :sign

  validates :about, :presence => true
  validates :loc_lat_from_gps, :loc_lng_from_gps, :presence => true,
    :if => Proc.new {|r| r.loc_lat_from_user.blank? && r.loc_lng_from_user.blank?}

  def about
    sign || camera
  end

  # this doesn't actually do anything; about assignment is done via self.camera= or self.sign=
  def about=(about)
    unless about.to_s == "camera" || about.to_s == "sign"
      errors.add(:about, "must be a sign or a camera but a "+about+" was given.")
    end
  end


end

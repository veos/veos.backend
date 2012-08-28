class Report < ActiveRecord::Base
  attr_protected :id, 
    :installation_attributes, # hacky way to ignore installation stuff, since we don't want this updated via nested attributes
    :surveilled_space, :sign_stated_purpose, :sign_properties # client is sending these for some reason... probably client-side bug, but patching it here for now

  belongs_to :installation
  has_many :photos
  has_many :tags, :class_name => ReportTag.name

  accepts_nested_attributes_for :photos, :allow_destroy => true
  accepts_nested_attributes_for :tags, :allow_destroy => true

  validates :loc_lat_from_gps, :loc_lng_from_gps, :presence => true,
    :if => Proc.new {|r| r.loc_lat_from_user.blank? && r.loc_lng_from_user.blank?}

  validates :owner_identifiable, :presence => true

  validates :owner_name, :presence => true,
    :if => Proc.new {|r| r.owner_identifiable }

  include GeoMixin

  def loc_lat
    loc_lat_from_user || loc_lat_from_gps
  end

  def loc_lng
    loc_lng_from_user || loc_lng_from_gps
  end

end

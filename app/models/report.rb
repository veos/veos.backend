class Report < ActiveRecord::Base
  attr_protected :id

  belongs_to :installation
  has_many :photos
  has_many :sign_tags

  accepts_nested_attributes_for :photos

  validates :loc_lat_from_gps, :loc_lng_from_gps, :presence => true,
    :if => Proc.new {|r| r.loc_lat_from_user.blank? && r.loc_lng_from_user.blank?}

end

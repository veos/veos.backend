require 'digest/md5'

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

  validates :owner_identifiable, 
    :acceptance => { 
      :accept => false, 
      :message => "- if you cannot determine the installation's owner, check the 'Cannot identify owner' checkbox" 
    },
    :if => Proc.new {|r| r.owner_name.blank? }


  validates :owner_name, :presence => {
      :message => "must be entered; if you cannot determine the installation's owner, check the 'Cannot identify owner' checkbox" 
    },
    :if => Proc.new {|r| r.owner_identifiable }

  validates :owner_type, :presence => {
      :message => "must be selected"
    },
    :if => Proc.new {|r| r.owner_identifiable}

  validates :has_sign, :inclusion => {
      :in => [true, false],
      :message => "must be either 'Yes' or 'No'"
    }

  include GeoMixin

  def loc_lat
    loc_lat_from_user || loc_lat_from_gps
  end

  def loc_lng
    loc_lng_from_user || loc_lng_from_gps
  end

  def contributor_id=(identifier)
    self[:contributor_id] = Digest::MD5.hexdigest(identifier)
  end

  def tagged_by=(identifier)
    self[:tagged_by] = Digest::MD5.hexdigest(identifier)
  end
end

class Sign < ActiveRecord::Base
  attr_protected :id

  belongs_to :report

  has_many :photos, :as => :of_object # note that spec currently only allows for one photo, but we have support for many
  has_many :stated_purposes, :class_name => "SignStatedPurpose"
  has_many :stated_properties, :class_name => "SignStatedProperty"

  accepts_nested_attributes_for :photos
end

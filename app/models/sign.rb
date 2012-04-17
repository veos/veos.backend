class Sign < ActiveRecord::Base
  belongs_to :report

  has_many :photos, :as => :object # note that spec currently only allows for one photo, but we have support for many
  has_many :stated_purposes, :class_name => "SignStatedPurpose"
  has_many :stated_properties, :class_name => "SignStatedProperty"
end

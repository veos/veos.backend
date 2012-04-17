class Sign < ActiveRecord::Base
  belongs_to :report

  has_attached_file :photo

  has_many :stated_purposes, :class_name => "SignStatedPurpose"
  has_many :stated_properties, :class_name => "SignStatedProperty"
end

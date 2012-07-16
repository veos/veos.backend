class Organization < ActiveRecord::Base
  attr_protected :id

  has_many :installations
end

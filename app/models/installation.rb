class Installation < ActiveRecord::Base
  attr_protected :id

  has_many :reports
  belongs_to :organization
end

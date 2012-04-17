class Camera < ActiveRecord::Base
  attr_protected :id

  belongs_to :report

  has_many :photos, :as => :of_object # note that spec currently only allows for one photo, but we have support for many
  has_many :pointed_at, :class_name => "CameraSpace"
end

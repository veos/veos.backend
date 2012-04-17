class Camera < ActiveRecord::Base
  belongs_to :report

  has_attached_file :photo

  has_many :pointed_at, :class_name => "CameraSpace"
end

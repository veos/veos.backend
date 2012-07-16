class PhotoTag < ActiveRecord::Base
  attr_protected :id

  belongs_to :photo
end

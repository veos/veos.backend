class Report < ActiveRecord::Base
  # note that current spec allows only camera OR sign, not both; 
  # but backend model currently actually allows both a camera and a sign
  has_one :camera
  has_one :sign

  
end

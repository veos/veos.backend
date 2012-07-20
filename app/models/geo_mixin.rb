module GeoMixin
  R = 6372.7976 # radius of the earth in km

  # Distance from this object's <loc_lat,loc_lng> to the given <to_lat,to_lng>; 
  # calculated using the haversine formula.
  # See http://www.codecodex.com/wiki/Calculate_Distance_Between_Two_Points_on_a_Globe
  # 
  # NOTE: Precision on this seems to be quite a bit different between the SQL and Ruby implementation,
  #       so distances calculated via by this ruby function will be slightly different from those calculated
  #       SQL expression defined in Installation.haversine_sql. However they should be accurate to 0.001 km (1 m).
  def distance_to(to_lat, to_lng)
    rad = Math::PI / 180
    lat_rad = loc_lat * rad
    lng_rad = loc_lng * rad
    to_lat_rad = to_lat * rad
    to_lng_rad = to_lng * rad
    lat_dist = lat_rad - to_lat_rad
    lng_dist = lng_rad - to_lng_rad

    return R * 2 * Math.asin(
      Math.sqrt(
        ((Math.sin(lat_dist)/2.0) ** 2) + 
        Math.cos(lat_rad) * 
        Math.cos(to_lat_rad) * 
        ((Math.sin(lng_dist)/2.0) ** 2)
      )
    )
  end
end
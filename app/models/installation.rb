class Installation < ActiveRecord::Base

  COMPLIANCE_RED   = 1
  COMPLIANCE_AMBER = 2
  COMPLIANCE_GREEN = 3

  attr_protected :id

  has_many :reports
  belongs_to :organization

  has_one :latest_report, 
    :class_name => Report.name,
    :order => 'created_at DESC'

  scope :near, lambda {|lat, lng, max_dist|
    dist = haversine_sql(Installation.sanitize(lat), Installation.sanitize(lng), 'IFNULL(loc_lat_from_user,loc_lat_from_gps)', 'IFNULL(loc_lng_from_user,loc_lng_from_gps)')
    joins(:latest_report).
    select("installations.*, #{dist} AS distance").
    where(
      "reports.id = (SELECT id FROM reports r2 WHERE r2.installation_id = installations.id ORDER BY created_at DESC LIMIT 1) 
        AND (#{dist} <= ?)", 
      max_dist.to_f
    ).
    order(dist)
  }

  include GeoMixin

  def loc_lat
    latest_report && (latest_report.loc_lat_from_user || latest_report.loc_lat_from_gps)
  end

  def loc_lng
    latest_report && (latest_report.loc_lng_from_user || latest_report.loc_lng_from_gps)
  end

  def loc_description
    latest_report && (latest_report.loc_description_from_user || latest_report.loc_description_from_google)
  end

  def owner_name
    latest_report && latest_report.owner_name
  end

  def owner_aliases
    reports.collect{|r| r.owner_name}.uniq
  end

  def owner_type
    latest_report && latest_report.owner_type
  end

  def photos
    latest_report && latest_report.photos
  end

  def tags
    latest_report && latest_report.tags
  end

  def compliance_level
    if compliance_level_override
      return compliance_level_override
    end

    if !latest_report
      return nil
    end

    if latest_report.has_sign?
      return COMPLIANCE_AMBER
    else
      return COMPLIANCE_RED
    end
  end

  # A SQL SELECT statement for the haversine function (tested only with MySQL) to calculate the distance between
  # geo point a and geo point b.
  # Based on code from http://www.codecodex.com/wiki/Calculate_Distance_Between_Two_Points_on_a_Globe 
  #
  # NOTE: Precision on this seems to be quite a bit different between the SQL and Ruby implementation,
  #       so distances calculated by this SQL expression will be slightly different from those calculated
  #       by the distance_to method in GeoMixin. However they should be accurate to 0.001 km (1 m).
  def self.haversine_sql(a_lat, a_lng, b_lat, b_lng)
    r = GeoMixin::R
    a_lat_rad = "RADIANS(#{a_lat})"
    a_lng_rad = "RADIANS(#{a_lng})"
    b_lat_rad = "RADIANS(#{b_lat})"
    b_lng_rad = "RADIANS(#{b_lng})"
    lat_dist = "#{a_lat_rad} - #{b_lat_rad}"
    lng_dist = "#{a_lng_rad} - #{b_lng_rad}"
    "(2 * ASIN(SQRT(POW(SIN(#{lat_dist}) / 2,2) + COS(#{a_lat_rad}) * COS(#{b_lat_rad}) * POW(SIN(#{lng_dist}) / 2,2))) * #{r})"
  end

end

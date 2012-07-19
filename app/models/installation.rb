class Installation < ActiveRecord::Base
  attr_protected :id

  has_many :reports
  belongs_to :organization

  has_one :latest_report, 
    :class_name => "Report",
    :order => 'created_at'

  def loc_lat
    latest_report.loc_lat_from_user || latest_report.loc_lat_from_gps
  end

  def loc_lng
    latest_report.loc_lng_from_user || latest_report.lng_lat_from_gps
  end

  def loc_description
    latest_report.loc_description_from_user || latest_report.loc_description_from_google
  end

  def owner_name
    latest_report.owner_name
  end

  def owner_aliases
    reports.collect{|r| r.owner_name}.uniq
  end

  def owner_type
    latest_report.owner_type
  end


end

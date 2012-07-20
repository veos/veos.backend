class ReportTag < ActiveRecord::Base
  attr_protected :id

  belongs_to :report
end

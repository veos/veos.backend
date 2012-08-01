class ReportsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @reports = Report.find(:all)
    respond_with_report(@reports)
  end

  def show
    @report = Report.find(params[:id])
    respond_with_report(@report)
  end

  def amend
    @inst = Installation.find(params[:installation_id])
    @old_report = @inst.latest_report
    @new_report = @old_report.dup

    @old_report.photos.each {|p| p2 = p.dup; p2[:report_id] = nil; @new_report.photos << p2}
    @old_report.tags.each {|t| t2 = t.dup; t2[:report_id] = nil; @new_report.tags << t2}

    respond_with_report(@new_report)
  end

  def create
    Report.transaction do
      @report = Report.create(params[:report])
      unless @report.installation
        @report.create_installation
        @report.save!
      end
    end

    respond_with_report(@report)
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes(params[:report])
    respond_with_report(@report)
  end

  protected
  def respond_with_report(report)
    respond_with(report, :include => {
      :installation => {:include => :organization},
      :tags => {}, 
      :photos => {:include => :tags, :methods => [:url, :big_url, :thumb_url]}
    })
  end

end

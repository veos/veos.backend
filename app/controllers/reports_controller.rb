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

    @old_report.photos.each do |p| 
      p2 = p.dup
      p2[:report_id] = nil
      @new_report.photos << p2
    end
    @old_report.tags.each do |t| 
      t2 = t.dup
      t2[:report_id] = nil
      @new_report.tags << t2
    end

    respond_with_report(@new_report)
  end

  def create

    Report.transaction do
      @report = Report.create(params[:report])
      if !@report.installation && @report.valid?
        @report.create_installation

        if @report.contributor_id.blank?
          @report.contributor_id = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
        end

        @report.save
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

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

  def create
    @report = Report.create(params[:report])
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
      :sign_tags => {}, 
      :photos => {:include => :photo_tags, :methods => [:url, :big_url, :thumb_url]}
    })
  end

end

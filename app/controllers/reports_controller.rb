class ReportsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @reports = Report.find(:all)
    respond_with(@reports,  :include => [:camera, :sign])
  end

  def show
    @report = Report.find(params[:id])
    respond_with(@report, :include => [:camera, :sign])
  end

  def create
    @report = Report.create(params[:report])
    respond_with(@report)
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes(params[:report])
    respond_with(@report)
  end

end

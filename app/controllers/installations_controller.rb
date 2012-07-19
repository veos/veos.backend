class InstallationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @inst = Installation.all
    respond_with(@inst, :methods => :latest_report)
  end

  def show
    @inst = Installation.find(params[:id])
    respond_with(@inst, :methods => :latest_report)
  end

end

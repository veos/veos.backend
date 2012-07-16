class OrganizationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @org = Organization.all
    respond_with(@org)
  end

  def show
    @org = Organization.find(params[:id])
    respond_with(@org)
  end

end

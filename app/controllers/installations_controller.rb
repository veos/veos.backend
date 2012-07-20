class InstallationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @inst = Installation.all
    respond_with_installation(@inst)
  end

  def near
    Installation.to_lat = params[:lat].to_f
    Installation.to_lng = params[:lng].to_f
    @inst = Installation.near(params[:lat],params[:lng],params[:max_dist])
    respond_with_installation(@inst)
  end

  def show
    @inst = Installation.find(params[:id])
    respond_with_installation(@inst)
  end

  protected
  def respond_with_installation(inst)
    meths = [:latest_report, :loc_lat, :loc_lng, :loc_description, 
      :owner_name, :owner_aliases, :owner_type]

    respond_with(inst, :methods => meths)
  end

end

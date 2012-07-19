class InstallationsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @inst = Installation.all
    respond_with(@inst, :methods => 
        [:latest_report, :loc_lat, :loc_lng, :loc_description, 
          :owner_name, :owner_aliases, :owner_type]
      )
  end

  def show
    @inst = Installation.find(params[:id])
    respond_with(@inst, :methods => 
        [:latest_report, :loc_lat, :loc_lng, :loc_description, 
          :owner_name, :owner_aliases, :owner_type]
      )
  end

end

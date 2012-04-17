class CamerasController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    @camera = Camera.create(params[:camera])
    respond_with(@camera)
  end

end

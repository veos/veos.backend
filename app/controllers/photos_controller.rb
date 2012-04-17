class PhotosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def create
    @photo = Photo.create(params[:photo])
    Rails.logger.debug @photo.to_json
    respond_with(@photo)
  end

end

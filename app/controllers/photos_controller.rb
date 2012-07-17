class PhotosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    @photos = Photo.all
    respond_with(@photos, :methods => :url, :include => :tags)
  end

  def show
    @photo = Photo.find(params[:id])
    respond_with(@photo, :methods => :url, :include => :tags)
  end

  def create
    @photo = Photo.create(params[:photo])
    Rails.logger.debug @photo.to_json
    respond_with(@photo, :methods => :url, :include => :tags)
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(params[:photo])
    respond_with(@photo, :methods => :url, :include => :tags)
  end

end

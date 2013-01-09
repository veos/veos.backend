class PhotosController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :json
  respond_to :html, :only => [:index, :show]

  def index
    @photos = Photo.find(: all, :order => "updated_at DESC")
    respond_with(@photos, :methods => [:url, :thumb_url, :big_url], :include => :tags)
  end

  def show
    @photo = Photo.find(params[:id])
    respond_with(@photo, :methods => [:url, :thumb_url, :big_url], :include => :tags, :layout => false)
  end

  def create
    @photo = Photo.create(params[:photo])
    Rails.logger.debug @photo.to_json
    respond_with(@photo, :methods => [:url, :thumb_url, :big_url], :include => :tags)
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(params[:photo])
    respond_with(@photo, :methods => [:url, :thumb_url, :big_url], :include => :tags)
  end

end

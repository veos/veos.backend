class SignsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    @sign = Sign.create(params[:sign])
    respond_with(@report)
  end

end

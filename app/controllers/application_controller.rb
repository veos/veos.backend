require "#{Rails.root}/lib/responders/json_responder"

class ApplicationController < ActionController::Base

  skip_before_filter :verify_authenticity_token

  responders :json
  
end

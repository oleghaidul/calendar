require "app_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = AppResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end
end

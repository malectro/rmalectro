class Admin::AdminController < ActionController::Base
  protect_from_forgery

  #activate this for production
  #before_filter :authenticate

  layout "admin"

  def index

  end

private

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end

end


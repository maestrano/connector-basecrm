class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_active_admin_user!
    authenticate_or_request_with_http_basic('Admin Connectors') do |username, password|
      ENV['ADMIN_USERNAME'].present? &
      ActiveSupport::SecurityUtils.secure_compare(username, ENV['ADMIN_USERNAME']) &
      ActiveSupport::SecurityUtils.secure_compare(password, ENV['ADMIN_PASSWORD'])
    end
  end
end

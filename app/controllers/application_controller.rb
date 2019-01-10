class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception unless :json_request?

  def json_request?
    request.format.json?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :strava_id, :first_name, :last_name, :screen_name])
  end
end

class ApplicationController < RocketPants::Base
  include ActionController::Cookies
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  #map_error! CanCan::AccessDenied, RocketPants::Unauthorized
  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def current_user(auth_token)
    if !auth_token
      auth_token = cookies[:auth_token]
    end
      @current_user ||= User.find_by(auth_token: auth_token) if auth_token
  end
  helper_method :current_user

  def set_current_user(user)
    @current_user = user
  end
  helper_method :set_current_user

  def authenticate_user!
    error! :unauthenticated unless current_user(params[:auth_token])
  end
end
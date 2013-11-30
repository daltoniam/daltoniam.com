class ApplicationController < RocketPants::Base
  include ActionController::Cookies
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  #map_error! CanCan::AccessDenied, RocketPants::Unauthorized
  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def current_user(auth_token = nil)

  	@current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  	#unless not @current_user
	#  	if auth_token
	#  		@current_user =
	#  	end
	#end

  end
  helper_method :current_user

  def authenticate_user!
    error! :unauthenticated unless current_user
  end
end
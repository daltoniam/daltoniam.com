class SessionsController < ApplicationController
  before_filter :authenticate_user!, except: [:create]
  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      set_current_user(user)
      cookies.permanent[:auth_token] = user.auth_token
      expose user
    else
      error! :unauthenticated
    end
  end

  def destroy
    cookies.delete(@current_user.auth_token)
    set_current_user(nil)
    expose 200
  end
end
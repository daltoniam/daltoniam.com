class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:create, :forgot_password, :change_password]
  version 1

  def index
    authorize! :index, User
    expose User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    authorize! :show, @user
    expose @user
  end

  def create
    @user = User.new(user_create_params)
    @user.add_role :commenter
    @user.save!
    expose @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    @user.update(user_update_params)
    expose @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy!
    expose @user
  end


  def forgot_password
    if @user = User.where(email: params[:email]).first
      @user.generate_password_reset_token!

      UserMailer.forgot_password_email(@user).deliver

      responds true
    else
      error! :not_found
    end
  end

  def change_password
    if @user = User.where(password_reset_token: params[:token]).first
      # Update password and clear reset token
      @user.update_attributes!(user_password_params.merge(password_reset_token: nil))

      # Sign the user in
      set_current_user(@user)

      expose @user
    else
      error! :not_found
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
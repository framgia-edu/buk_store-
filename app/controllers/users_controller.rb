class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "activation_mesage"
      redirect_to root_url
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def show
    redirect_to root_url && return unless @user.activated == true
  end

  private
  def user_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end

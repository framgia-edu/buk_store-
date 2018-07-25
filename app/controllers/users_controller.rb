class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :show, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "log_msg"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end

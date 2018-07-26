class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index,:newUser]

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end
  def create
    if logged_in? && current_user.admin?
        create_by_admin
    else
        create_by_user
    end
  end
  def create_by_user
    @user = User.new user_params
    if @user.save
      flash[:success] = t "welcome"
      redirect_to root_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end
  def create_by_admin
    @user = User.new admin_params
    if @user.save
      flash[:success] = t "welcome"
      redirect_to users_path
    else
      flash[:danger] = t ".create_failed"
      render :newUser
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t ".delete_success"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation
  end

  def admin_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation, :admin
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".log_msg"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user? @user
  end
end

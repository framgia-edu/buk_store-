class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "welcome"
      redirect_to root_path
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user)
          .permit :name, :gender, :birthday, :address, :phone_number,
            :card_number, :email, :password, :password_confirmation
  end
end

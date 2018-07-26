class BooksController < ApplicationController
  before_action :search_book, only: [:index]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :addbook]
  def index
    @categories = Category.order :category_name
  end

  def new
    @book = Book.new
  end

  def create
    if logged_in? && current_user.admin?
      @book = Book.new book_params
      if @book.save
        flash[:success] = "welcome"
        redirect_to root_path
      else
        flash[:danger] = "create_failed"
        render :new
      end
    else
      flash[:danger] = "Nahhhhh"
      redirect_to root_path
    end
  end

  def show; end

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

  private
  def book_params
    params.require(:book).permit :name, :category
  end
  def search_book
    @book = if params[:query].present?
              Book.search(params[:query])
                  .paginate page: params[:page],
                    per_page: Settings.per_page_search
            else
              Book.all.paginate page: params[:page],
                per_page: Settings.per_page
            end
    return if @book
    flash[:danger] = t("not_found")
    redirect_to root_path
  end
end

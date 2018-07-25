class BooksController < ApplicationController
  before_action :search_book, only: [:index]
  def index
    @categories = Category.order :category_name
  end

  def show; end

  private

  def search_book
    @book = if params[:query].present?
              Book.search(params[:query]).paginate page: params[:page],
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

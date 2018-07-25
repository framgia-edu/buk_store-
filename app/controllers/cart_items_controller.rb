class CartItemsController < ApplicationController
  before_action :find_cart_item, only: [:add_quantity, :reduce_quantity,
    :destroy]

  def create
    chosen_book = Book.find params[:book_id]
    current_cart = @current_cart

    if current_cart.books.include?(chosen_book)
      @cart_item = current_cart.cart_items.find_by(book_id: chosen_book)
      @cart_item.quantity += 1
    else
      @cart_item = CartItem.new
      @cart_item.cart = current_cart
      @cart_item.book = chosen_book
      @cart_item.quantity = 1
    end

    @cart_item.save
    redirect_to cart_path
  end

  def add_quantity
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to cart_path
  end

  def reduce_quantity
    @cart_item.quantity -= 1 if @cart_item.quantity > 1
    @cart_item.save
    redirect_to cart_path
  end

  def destroy
    @cart_item.destroy
    flash[:success] = t("delete_cart_item")
    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :book_id, :cart_id)
  end

  def find_cart_item
    @cart_item = CartItem.find params[:id]
  end
end

class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    chosen_cart = Cart.find params[:id]
    current_user = @current_user
    @order = Order.new
    @order.user = current_user
    @order.cart = chosen_cart
    @order.total_price = chosen_cart.sub_total
    @order.save
    chosen_cart.destroy
    flash[:success] = t("thankyou")
    redirect_to root_path
  end

  def show
    @order = Order.find params[:id]
  end

  private

  def order_params
    params.require(:order).permit :user_id, :cart_id, :total_price
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t("log_msg")
    redirect_to login_url
  end

end

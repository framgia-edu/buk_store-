class HistoryOrdersController < ApplicationController
  def index
    @cart_items = CartItem.find(user_id: current_user.id)
  end
end

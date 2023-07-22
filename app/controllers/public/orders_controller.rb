class Public::OrdersController < ApplicationController
  def new
  end

  def create
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def complete
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)

  end

  private

end

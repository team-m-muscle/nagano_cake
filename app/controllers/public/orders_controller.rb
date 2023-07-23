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
  end

  def index
  end

  private

end

class Public::CartItemsController < ApplicationController

  def index
  end

  def show
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

end

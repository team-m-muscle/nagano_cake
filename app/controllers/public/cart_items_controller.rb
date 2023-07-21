class Public::CartItemsController < ApplicationController

  def index
    # テスト用
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def show
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end

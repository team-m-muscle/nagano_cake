class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @items = Item.all
    @cart_item = @items.all
    
    
  end
  def create
    @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.quantity = CartItem.new(cart_item_params).quantity
    else
      @cart_item = CartItem.new(cart_item_params)
    end
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    @cart_item = current_customer
    @item = Item.all
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end   

end

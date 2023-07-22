class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    params[:order][:payment_option] = params[:order][:payment_option].to_i
    @order = Order.new(order_params)
    case params[:order][:select_address]
      when "0"
        @order.name = current_customer.last_name + current_customer.first_name
        @order.address = current_customer.address
        @order.post_code = current_customer.post_code
      when "1"
        @address = Address.find(params[:order][:address_id])
        @order.name = @address.name
        @order.address = @address.address
        @order.post_code = @address.post_code
      when "2"
    end

  end

  def complete
  end

  def show
  end

  def index
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :shipping_fee, :total_price, :payment_option, :address, :post_code, :name)
  end
end

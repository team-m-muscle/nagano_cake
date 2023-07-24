class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    # orderを保存
    @order = Order.new(order_params)
    @order.save

    # order_itemsを保存
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.item_id = cart_item.item_id
      @order_item.order_id = @order.id
      @order_item.quantity = cart_item.quantity
      @order_item.price = cart_item.item.with_tax_price
      @order_item.save
    end

    # cart_itemsを破棄
    cart_items.destroy_all

    # 注文完了ページにリダイレクト
    redirect_to orders_complete_path
  end

  def confirm
    @total_price = 0
    @shipping_fee = 800
    @billing_price = 0
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
        redirect_to customers_confirm_path if @order.name.length() == 0
        redirect_to customers_confirm_path if @order.address.length() == 0
        redirect_to customers_confirm_path if @order.post_code.length() == 0
    end
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

  def order_params
    params.require(:order).permit(:customer_id, :shipping_fee, :total_price, :payment_option, :address, :post_code, :name)
  end

end

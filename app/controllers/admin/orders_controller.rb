class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderItem.where(order_id: @order)
    @production_status = @order.order_items.pluck(:status)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderItem.where(order_id: @order)
    if @order.update(order_status_params)
      flash[:notice] = "注文ステータスを変更しました。"
      redirect_to admin_root_path
    else
      render "show"
    end
  end

  private

  def order_status_params
    params.require(:order).permit(:status)
  end

end
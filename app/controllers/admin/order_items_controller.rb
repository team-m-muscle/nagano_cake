class Admin::OrderItemsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = Order.find(params[:order_item][:order_item_id])
    if @order_detail.update(order_item_status_params)
      flash[:notice] = "制作ステータスを変更しました。"
      redirect_to admin_root_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_item_status_params
    params.require(:order_item).permit(:making_status)

  end

end

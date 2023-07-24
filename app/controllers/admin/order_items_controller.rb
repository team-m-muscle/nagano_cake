class Admin::OrderItemsController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_detail = Order.find(params[:order_item][:order_item_id])
    if @order_detail.update(order_detail_status_params)
      if @order.order_items.pluck(:making_status).include?("製作中")
        @order.order_status = 2
        @order.save
      elsif @order.order_details.pluck(:making_status).all?{|status|status == "製作完了"}
        @order.order_status = 3
        @order.save
      end

    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_detail_status_params
    params.require(:order_item).permit(:making_status)

  end

end

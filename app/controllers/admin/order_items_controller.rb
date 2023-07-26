class Admin::OrderItemsController < ApplicationController

  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderItem.find(params[:order_item][:order_item_id])


    is_updated = true
    if @order_detail.update(order_item_status_params)
        @order.update(status: "in_production" ) if @order_detail.making_status == "in_making"

        @order_details = @order.order_items.pluck(:making_status)
        @order_details.each do |order_detail|
          if order_detail != "complete"
            is_updated = false
          end
        end
        @order.update(status: "preparing_delivery") if is_updated
    end
    redirect_to request.referer
  end

  private

  def order_item_status_params
    params.require(:order_item).permit(:making_status)
  end

end

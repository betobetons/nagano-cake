class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order
    if @order.status == 1
      @order.order_details.update(making_status: 1)
    end
    flash[:notice] = "変更しました"
    redirect_back(fallback_location: root_path)
  end
  private

  def order_params
    params.require(:order).permit(:status)
  end
end

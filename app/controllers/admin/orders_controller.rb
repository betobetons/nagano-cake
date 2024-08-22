class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == 'checked_payment'
      @order.order_details.update(making_status: 1)
    else @order.status == 'waiting_payment'
      @order.order_details.update(making_status: 0)
    end
    flash[:notice] = "変更しました"
    redirect_back(fallback_location: root_path)
  end
  private

  def order_params
    params.require(:order).permit(:status)
  end
end

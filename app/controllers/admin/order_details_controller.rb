class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    # @order_details = OrderDetail.where(item_id: params[:item_id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == 'in_making'
      @order.update(status: "in_making")
    elsif @order.order_details.count == @order.order_details.where(making_status: "finish").count
      @order.update(status: "ready")
    end
    flash[:notice] = "変更しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
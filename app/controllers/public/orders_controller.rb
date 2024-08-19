class Public::OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  # def confirm
  #   @order = Order.new(order_params)
  #   @address = Address.find(params[:order][:address_id])
  #   @order.post_code = @address.post_code
  #   @order.address = @address.address
  #   @order.name = @address.first_name + current_customer.last_name
  #   selected_address = params[:order][:select_address]
  # end

def confirm
  @order_fee = 800
  @carts = current_customer.carts
  @cart_items= current_customer.carts.all
    # カートに入ってる商品の合計金額
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  if params[:select_address] == 0
    @order = Order.new(order_params) 
    @order.post_code = current_customer.post_code 
    @order.address = current_customer.address 
    @order.name = current_customer.first_name + current_customer.last_name
  elsif params[:select_address] == 1
    @order = Order.new(order_params) 
    @address = Address.find(params[:order][:address_id]) 
    @order.post_code = @address.post_code 
    @order.address = @address.address 
    @order.name = @address.name
  end
end
  # if params[:address] == 2

  def complete
  end
  
  private
  
  def order params
    params.require(:order).permit(:post_code, :name, :address, :customer_id, :payment, :total, :fee, :status)
  end
end

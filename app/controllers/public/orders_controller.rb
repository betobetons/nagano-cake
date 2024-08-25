class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]
  before_action :set_addresses, only: [:new, :confirm]

  def cart_check
    unless current_customer.carts.exists?
      flash[:danger] = "カートが空です"
      redirect_to items_path
    end
  end

  def new
    @order = Order.new(customer: current_customer)
  end

  def create
    @order = build_order_from_params
    if @order.save
      create_order_details
      current_customer.carts.destroy_all
      redirect_to complete_orders_path
    else
      flash[:alert] = "住所が見つかりませんでした。"
      redirect_to items_path
    end
  end

  def confirm
    @carts = current_customer.carts
    @order = Order.new(order_params)
    @order_fee = 800
    @sub_total = current_customer.carts.sum(&:sum_of_price)
    @total = @order_fee + @sub_total
    set_order_address
    redirect_to new_order_path and return if flash[:alert]
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:post_code, :name, :address, :customer_id, :payment, :total, :fee, :status)
  end

  def build_order_from_params
    order = current_customer.orders.build(order_params)
    order.fee = 800
    order.total = calculate_total(order)
    order.status = determine_status(order.payment)
    set_order_address(order)
    order
  end

  def calculate_total(order)
    cart_total = current_customer.carts.sum { |cart| cart.item.price * cart.quantity }
    order.fee + (cart_total * 1.1)
  end

  def determine_status(payment)
    payment == 'transfer' ? 0 : 1
  end

  def set_order_address(order = nil)
    case params[:order][:select_address]
    when 'my_address'
      order_or_flash_address(current_customer.post_code, current_customer.address, "#{current_customer.last_name} #{current_customer.first_name}", order)
    when 'registered_address'
      selected_address = Address.find_by(id: params[:order][:address_id])
      if selected_address
        order_or_flash_address(selected_address.post_code, selected_address.address, selected_address.name, order)
      else
        flash[:alert] = "住所が見つかりませんでした。"
      end
    when 'new_address'
      if params[:order][:post_code].blank? || params[:order][:address].blank? || params[:order][:name].blank?
        flash[:alert] = "住所を入力してください。"
      else
        order_or_flash_address(params[:order][:post_code], params[:order][:address], params[:order][:name], order)
      end
    else
      flash[:alert] = "不正な住所選択です。"
    end
  end

  def order_or_flash_address(post_code, address, name, order = nil)
    if order
      order.post_code = post_code
      order.address = address
      order.name = name
    else
      @order_post_code = post_code
      @order_address = address
      @order_name = name
    end
  end

  def create_order_details
    making_status = @order.status == 1 ? 'waiting_make' : 'stop_making'
    current_customer.carts.each do |cart|
      OrderDetail.create!(order_id: @order.id, item_id: cart.item_id, price: cart.item.price, quantity: cart.quantity, making_status: making_status)
    end
  end

  def set_addresses
    @addresses = current_customer.addresses
  end
end

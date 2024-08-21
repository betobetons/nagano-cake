class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.fee = 800
    @carts = Cart.where(customer_id: current_customer.id)
    ary = []
    @carts.each do |cart|
      ary << cart.item.price*cart.quantity
    end
    @cart_price = ary.sum
    @order.total = @order.fee + @cart_price
    @order.payment = params[:order][:payment]
    if @order.payment == 'transfer'
      @order.status = 0
    else
      @order.status = 1
    end

    selected_address_type = params[:order][:select_address]
    case selected_address_type
    when "my_address"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "registered_address"
      Address.find(params[:order][:address_id])
      selected = Address.find(params[:order][:address_id])
      @order.post_code = selected.post_code
      @order.address = selected.address
      @order.name = selected.name
    when "new_address"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    if @order.save
      if @order.status == 'checked_payment'
        @carts.each do |cart|
          OrderDetail.create!(order_id: @order.id, item_id: cart.item_id, price: cart.item.price, quantity: cart.quantity, making_status: 'waiting_make')
        end
      else @order.status == 'waiting_payment'
        @carts.each do |cart|
          OrderDetail.create!(order_id: @order.id, item_id: cart.item_id, price: cart.item.price, quantity: cart.quantity, making_status: 'stop_making')
        end
      end
      @carts.destroy_all
      redirect_to complete_orders_path
    else
      render :items
    end
  end

  def confirm
    @order = Order.new(order_params)
    @selected_address_type = params[:order][:select_address]  # select_addressの値を取得
    @order_fee = 800
    @carts = current_customer.carts
    @cart_items = current_customer.carts.all
    @sub_total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @total = @order_fee + @sub_total
    @payment = params[:order][:payment]

    # 選択された住所タイプに応じて住所情報を設定
    if @selected_address_type == 'my_address'
      @order_post_code = current_customer.post_code
      @order_address = current_customer.address
      @order_name = "#{current_customer.first_name} #{current_customer.last_name}"

    elsif @selected_address_type == 'registered_address'
      @selected_address = Address.find_by(id: params[:order][:address_id]) # 登録済み住所を取得
      if @selected_address
        @order_post_code = @selected_address.post_code
        @order_address = @selected_address.address
        @order_name = @selected_address.name
      else
        flash[:alert] = "住所が見つかりませんでした。"
        redirect_to new_order_path and return
      end

    else @selected_address_type == 'new_address'
      @order_post_code = params[:order][:post_code]
      @order_address = params[:order][:address]
      @order_name = params[:order][:name]
    end
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
end

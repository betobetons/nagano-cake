class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to confirm_orders_path
    else
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @selected_address_type = params[:order][:select_address]  # select_addressの値を取得
    @order_fee = 800
    @carts = current_customer.carts
    logger.debug "Selected address type: #{@selected_address_type}"
    logger.debug "Order params: #{order_params.inspect}"
    @cart_items = current_customer.carts.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
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

  private

  def order_params
    params.require(:order).permit(:post_code, :name, :address, :customer_id, :payment, :total, :fee, :status)
  end
end

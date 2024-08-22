class Public::CartsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @carts = current_customer.carts
    @cart_items = current_customer.carts.all
    @sub_total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart = current_customer.carts.find_by(item_id: cart_params[:item_id])

    if @cart
      @cart.quantity += cart_params[:quantity].to_i
      @cart.save
      redirect_to carts_path
    else
      @cart = current_customer.carts.new(cart_params)
      @cart.save
      redirect_to carts_path
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      flash[:notice] = "カートが更新されました。"
    else
      flash[:alert] = "カートの更新に失敗しました。"
    end
    redirect_to carts_path
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    Cart.where(customer_id: current_customer.id).destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :item_id)
  end
end

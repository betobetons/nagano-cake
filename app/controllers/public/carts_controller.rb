class Public::CartsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @carts = current_customer.carts
    @sub_total = calculate_sub_total(@carts)
  end

  def create
    @cart = current_customer.carts.find_by(item_id: cart_params[:item_id])

    if @cart
      @cart.quantity += cart_params[:quantity].to_i
    else
      @cart = current_customer.carts.new(cart_params)
    end

    if @cart.save
      redirect_to carts_path
    else
      flash[:alert] = 'カートに追加できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @cart = current_customer.carts.find(params[:id])
    
    if @cart.update(cart_params)
      @sub_total = calculate_sub_total(current_customer.carts)
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = 'カートの更新に失敗しました。'
      redirect_back(fallback_location: carts_path)
    end
  end

  def destroy
    @cart = current_customer.carts.find(params[:id])
    @cart.destroy
    @sub_total = calculate_sub_total(current_customer.carts)
    redirect_back(fallback_location: carts_path)
  end

  def destroy_all
    current_customer.carts.destroy_all
    flash[:notice] = 'カートを空にしました。'
    redirect_back(fallback_location: carts_path)
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :item_id)
  end

  def calculate_sub_total(carts)
    carts.inject(0) { |sum, cart| sum + cart.sum_of_price }
  end
end

class Public::CartsController < ApplicationController
  def index
    @carts = current_customer.carts
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
    render "item"
  end
end

  
  private
  
  def cart_params
     params.require(:cart).permit(:quantity, :item_id)
    
  end
  
end

class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @cart_items= current_customer.carts.all
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end
  
  def show
    @item = Item.find(params[:id])
    @cart = Cart.new
  end
  
  
  private
  
end

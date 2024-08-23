class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
    @cart = Cart.new
  end


  private

end

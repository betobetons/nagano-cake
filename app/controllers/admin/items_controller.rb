class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @item = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @categories = Category.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "商品を登録しました"
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:price, :name, :description, :image, :category_id)
  end

end

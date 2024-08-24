class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  protect_from_forgery
  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page]).per(10)
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

  def update
    @categories = Category.all
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path, notice: "商品を編集しました"
    else
      @item = Item.find(params[:id])
      flash[:notice] = "保存に失敗しました"
      render :edit
    end
  end


  private
  def item_params
    params.require(:item).permit(:price, :name, :description, :image, :category_id, :is_active)
  end

end

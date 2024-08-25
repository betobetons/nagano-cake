class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "商品を登録しました"
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admin_items_path, notice: "商品を編集しました"
    else
      flash[:alert] = "保存に失敗しました"
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def item_params
    params.require(:item).permit(:price, :name, :description, :image, :category_id, :is_active)
  end
end

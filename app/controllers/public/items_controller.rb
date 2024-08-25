class Public::ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.page(params[:page]).per(8)
    @categories = Category.all
  end

  def show
    @cart = Cart.new
  end

  private

  # 共通のセットアップを行うメソッド
  def set_item
    @item = Item.find_by(id: params[:id])
    unless @item
      flash[:alert] = "アイテムが見つかりません"
      redirect_to items_path
    end
  end

  # 強いパラメータの定義（将来的に必要に応じて追加）
  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :image)
  end
end

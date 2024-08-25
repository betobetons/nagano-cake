class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash.now[:notice] = "保存に成功しました"
      respond_to do |format|
        format.js   # create.js.erb を呼び出す
      end
    else
      flash.now[:alert] = "保存に失敗しました"
      respond_to do |format|
        format.js   # create.js.erb を呼び出す
      end
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "保存に成功しました"
      redirect_to admin_categories_path
    else
      flash[:alert] = "保存に失敗しました"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash.now[:notice] = "削除に成功しました"
      respond_to do |format|
        format.js # destroy.js.erb を呼び出す
      end
    else
      flash.now[:alert] = "削除に失敗しました"
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

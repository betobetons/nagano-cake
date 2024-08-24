class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "保存に成功しました"
      redirect_to admin_categories_path
    else
    @categories = Category.all
    @category = Category.new
    flash[:notice] = "保存に失敗しました"
    redirect_back(fallback_location: root_path)
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "保存に成功しました"
      redirect_to admin_categories_path
    else
    @category = Category.find(params[:id])
    flash[:notice] = "保存に失敗しました"
    render :edit
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end

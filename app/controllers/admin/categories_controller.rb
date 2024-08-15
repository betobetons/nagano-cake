class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
    @categories = Category.all
    @category = Category.new
      render :index
    end
  end

  def update
  end

  def edit
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end

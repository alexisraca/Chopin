class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def create
    @category = Category.create(categories_params)
    @category.save
  end

  def categories_params
    params.require(:category).permit(:name)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
  end
end
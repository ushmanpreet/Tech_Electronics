class CategoriesController < ApplicationController
  def products
    @category = Category.find(params[:id])
    @products = @category.products
  end
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
end

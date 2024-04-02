class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:on_sale] == 'true'
      @products = @products.where(on_sale: true)
    end

    if params[:new] == 'true'
      @products = @products.where('created_at >= ?', 3.days.ago).order(created_at: :desc)
    else
      @products = @products.order(created_at: :asc)
    end

    @products = @products.search_by_keyword(params[:search])

    @products = @products.joins(:categories).where(categories: { category_name: params[:category_name] }) if params[:category_name].present?

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
  product = Product.find(product_id)

  session[:cart] ||= {}

  session[:cart][product_id] ||= 0
  session[:cart][product_id] += quantity

  redirect_to products_path, notice: "#{quantity} #{product.product_name.pluralize(quantity)} added to cart."
  end
end

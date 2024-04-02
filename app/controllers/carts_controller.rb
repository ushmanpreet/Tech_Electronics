class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @total_price = calculate_total_price
  end

  def update_quantity
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity if session[:cart].key?(product_id)
    redirect_to cart_path
  end

  def remove_from_cart
    product_id = params[:product_id]
    session[:cart].delete(product_id)
    redirect_to cart_path
  end

  private

  def calculate_total_price
    @cart.inject(0) do |total, (product_id, quantity)|
      product = Product.find_by(id: product_id)
      total += product&.price.to_f * quantity if product.present?
      total
    end
  end
end

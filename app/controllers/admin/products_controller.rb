class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    category_name = params[:product][:category_name]
    category = Category.find_by(category_name: category_name)
    @product.categories << category if category

    if @product.save
      redirect_to admin_dashboard_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:product][:delete_image] == '1' && @product.image.attached?
      @product.image.purge
    end

    @product.categories.clear

    category = Category.find_by(category_name: product_params[:category_name])
    @product.categories << category if category

    if @product.update(product_params.except(:category_name))
      redirect_to admin_dashboard_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @product.product_categories.destroy_all
    @product.destroy
    redirect_to admin_dashboard_path, notice: 'Product was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :stock_quantity, :image, :category_name, :on_sale)
  end
end

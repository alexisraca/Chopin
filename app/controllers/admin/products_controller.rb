class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Creacion Existosa"
      redirect_to admin_products_path
    end
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
  end

  def destroy
  end
  
  def product_params
    params.require(:product).
      permit(:name, :description, :cost, :price, :sku)
  end

end
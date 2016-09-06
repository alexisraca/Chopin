class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    params.merge!(main_variant: true)
    if @product.save
       @product.variants.create(name: params[:product][:name] , description: params[:product][:description] ,price: params[:variants][:price])
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
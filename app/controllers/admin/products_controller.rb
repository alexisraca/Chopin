class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Producto Guardado"
    end
  end

  def new
    @product = Product.new
    @product.build_main_variant
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Producto Guardado"
    end
  end

  def destroy
  end
  
  def product_params
    params.require(:product).
      permit(
        main_variant_attributes: [
          :name,
          :description,
          :cost,
          :price,
          :sku,
          :id,
          inventories_attributes: [
            :quantity,
            :expiration_date,
            :branch_id,
            :id
          ]
        ]
      )
  end
end
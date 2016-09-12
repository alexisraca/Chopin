class Admin::ProductsController < ApplicationController

  def index
   @q = Variant.ransack(params[:q])
   @variants = @q.result(distinct: true).order(:created_at)
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
    @product.main_variant.inventories.build
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
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Producto Borrado"
    end
  end
  
  def product_params
    params.require(:product).
      permit(
        main_variant_attributes: variant_attrs,
        common_variants_attributes: variant_attrs
      )
  end

  def variant_attrs
    [
      :name,
      :description,
      :cost,
      :price,
      :sku,
      :id,
      inventories_attributes: inventory_attrs
    ]
  end

  def inventory_attrs
    [
      :quantity,
      :expiration_date,
      :branch_id,
      :id
    ]
  end
end
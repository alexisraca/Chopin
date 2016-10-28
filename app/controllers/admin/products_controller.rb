class Admin::ProductsController < ApplicationController

  def index
    @q = base_variants_scope.includes(:product).ransack(params[:q])
    @variants = @q.result(distinct: true).
                  paginate(page: params[:page], per_page: 30).
                  order(:created_at)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @new_variant = Variant.count_variants.where(id: @product.main_variant.id).first
      flash[:notice] = "Producto guardado"
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
      flash[:notice] = "Producto guardado"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Producto borrado"
    end
  end

  private

  def base_variants_scope
    if params[:q] && params[:q][:deleted_at_not_null]
      Variant.unscoped
    else
      Variant
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
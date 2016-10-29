class Admin::VariantsController < ApplicationController
  before_action :set_product

  def destroy
    @variant = Variant.unscoped.find(params[:id])
    if destroy_variant
      flash[:notice] = "Producto borrado"
    else
      flash[:alert] = @destroyer.error
    end
  end

  def restore
    @variant = Variant.unscoped.find(params[:id])
    if @variant.restore
      flash[:notice] = "Producto restaurado"
    else
      flash[:alert] = "Hubo un error restaurando el producto"
    end
  end

  def edit
    @variant = Variant.unscoped.find(params[:id])
  end

  def update
    if @product.update(product_params)
      @variant = Variant.unscoped.where(id: params[:id]).first
      flash[:notice] = "Producto actualizado"
    end
  end

  private

  def destroy_variant
    @destroyer = VariantDestroyer.new(@variant)
    @destroyer.destroy!
    @destroyer.error.blank? ? true : false
  end

  def set_product
    return if params[:product_id].blank?
    @product = Product.find(params[:product_id])
  end

  def variant_params
    params.require(:variant).
      permit(
        :name, :description, :cost, :price,
        :sku, :id, :product_id,
        inventories_attributes: [
          :branch_id, :quantity, :expiration_date, :id
        ]
      )
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

class Admin::VariantsController < ApplicationController
  before_action :set_product

  def destroy
    @variant = Variant.unscoped.find(params[:id])
    if destroy_variant
      flash[:notice] = "Variante Borrada"
    else
      flash[:alert] = @destroyer.error
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
        :name,
        :description,
        :cost,
        :price,
        :sku,
        :id,
        :product_id,
        inventories_attributes: [
          :branch_id,
          :quantity,
          :expiration_date,
          :id
        ]
      )
  end
end

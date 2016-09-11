class Admin::VariantsController < ApplicationController
  before_action :set_product

  def index
    @variants = @product.variants.where(main_variant: false)
  end

  def new
    @variant = @product.variants.build
  end

  def create
    @variant = Variant.new(variant_params)
    if @variant.save
      flash[:notice] = "Producto Guardado"
    end
  end

  def edit
    @variant = Variant.find(params[:id])
  end

  def update
    @variant = Variant.find(params[:id])
    if @variant.update(variant_params)
      flash[:notice] = "Producto Guardado"
    end
  end

  private

  def set_product
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

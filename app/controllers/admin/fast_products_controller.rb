class Admin::FastProductsController < ApplicationController

  def new
    @fast_product_builder = FastProductBuilder.new
    @fast_product_builder.products.build.build_main_variant
  end

  def create
    begin
      FastProductBuilder.transaction do
        @fast_product_builder = FastProductBuilder.new(fast_product_builder_params)
        @fast_product_builder.save!
        redirect_to edit_admin_fast_product_path(@fast_product_builder)
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:warning] = "Error guardando los productos, por favor revise la información"
      render :new
    end
  end

  def edit
    @fast_product_builder = FastProductBuilder.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "¡Producto guardado!"
    end
  end

  private

  def fast_product_builder_params
    params.require(:fast_product_builder).
      permit(products_attributes:[main_variant_attributes:[:sku, :name, :price]])
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

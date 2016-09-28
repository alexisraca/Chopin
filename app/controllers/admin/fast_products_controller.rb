class Admin::FastProductsController < ApplicationController

  def new
    @fast_product_builder = FastProductBuilder.new
    @fast_product_builder.products.build.build_main_variant
  end

  def create
    @fast_product_builder = FastProductBuilder.create(fast_product_builder_params)
    @fast_product_builder.save
    redirect_to admin_products_path
  end

  def fast_product_builder_params
    params.require(:fast_product_builder).
      permit(products_attributes:[main_variant_attributes:[:sku, :name, :price]])
  end

end

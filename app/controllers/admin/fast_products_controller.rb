class Admin::FastProductsController < ApplicationController

  def new
    @fast_product_builder = FastProductBuilder.new
  end

end

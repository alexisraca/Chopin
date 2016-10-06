class SalesController < ApplicationController

  def index
    @q = base_variants_scope.count_variants.ransack(params[:q])
    @variants = @q.result(distinct: true)
  end

end
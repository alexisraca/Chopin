class Sales::VariantsController < ApplicationController
  def index
    @q = Variant.ransack(params[:q])
    @variants = @q.result(distinct: true).
                  paginate(page: params[:page], per_page: 10).
                  order(:created_at)
  end
end

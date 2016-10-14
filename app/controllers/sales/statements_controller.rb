class Sales::StatementsController < ApplicationController
  before_action :load_variants_view

  def edit
    @q = Variant.ransack(params[:q])
    @variants = @q.result(distinct: true).
                   paginate(page: params[:page], per_page: 10).
                   order(:created_at)
    @statement = Statement.find(params[:id])
    @order = @statement.order
  end

  def load_variants_view
    @variants_view = params[:variants_view] || :list
  end
end

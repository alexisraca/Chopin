class Sales::StatementsController < ApplicationController
  def edit
    @q = Variant.ransack(params[:q])
    @variants = @q.result(distinct: true).
                   paginate(page: params[:page], per_page: 10).
                   order(:created_at)
    @statement = Statement.find(params[:id])
    @order = @statement.order
  end
end

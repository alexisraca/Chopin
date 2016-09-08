class Admin::StatementsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @order.statements.create(state: "summary", total: 0.0)
  end

  private

  def statement_params
    params.permit(:order_id)
  end
end

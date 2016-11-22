class Sales::PaymentsController < ApplicationController
  before_action :set_statement

  def new
  end

  def create
    @payment = @statement.payments.create(type: payment_params[:type].classify)
  end

  private

  def set_statement
    @statement = Statement.find(params[:statement_id])
  end

  def payment_params
    params.permit(:total, :type)
  end
end

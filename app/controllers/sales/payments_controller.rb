class Sales::PaymentsController < ApplicationController
  before_action :set_statement

  def new
  end

  def create
    @payment = @statement.payments.new(type: payment_type, total: payment_params[:total])
    if @payment.save
      @payment.complete_payment
    else
      flash[:errors] = @payment.errors.full_messages
      render "type"
    end
  end

  def type
    @payment = @statement.payments.new(type: payment_type)
  end

  def next
  end

  private

  def set_statement
    @statement = Statement.find(params[:statement_id])
  end

  def payment_params
    params.permit(:total, :type)
  end

  def payment_type
    payment_params[:type].classify
  end
end

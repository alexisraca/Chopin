class Sales::PaymentsController < ApplicationController
  before_action :set_statement

  def new
    @payment = @statement.payments.build
  end

  def create
    @payment = @statement.payments.build(build_payment_params)
    if @payment.complete_payment
      flash[:success] = "Pago completo"
    else
      flash[:danger] = "Hubo un error al completar el pago"
    end
  end

  private

  def set_statement
    @statement = Statement.find(params[:statement_id])
  end

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def build_payment_params
    {
      total: payment_params[:amount],
      settled_at: DateTime.now,
      state: Payment::COMPLETE
    }
  end



end

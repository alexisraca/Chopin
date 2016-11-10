class Sales::PaymentsController < ApplicationController
  before_action :set_statement

  def new
    @payment = @statement.payments.build
  end

  def create
    if payment_params[:total].blank? && payment_params[:type] == "cash"
      flash[:danger] = "Por favor agrega un importe para cobrar"
      render :new
    end
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
    params.require(:payment).permit(:total, :type)
  end

  def build_payment_params
    {
      total: payment_params[:total],
      settled_at: DateTime.now,
      state: Payment::COMPLETE
    }
  end



end

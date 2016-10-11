class Sales::LineItemsController < ApplicationController

  def create
    add_line_item_to_statement
    if !@line_item.new_record?
      flash[:notice] = "Producto agregado"
    else
      flash[:danger] = "Ocurrio un error al agregar el producto"
    end
  end

  private

  def add_line_item_to_statement
    @variant = Variant.find(params[:variant_id])
    @statement = Statement.find(params[:statement_id])
    @line_item = @statement.add_line_item(@variant)
  end

  def create_line_item_params
    params.permit(:variant_id, :statement_id)
  end

end

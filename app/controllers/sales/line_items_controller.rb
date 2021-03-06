class Sales::LineItemsController < ApplicationController

  before_action :set_statement

  def create
    add_line_item_to_statement
    if !@line_item.new_record?
      flash[:notice] = "Producto agregado"
    else
      flash[:danger] = "Ocurrio un error al agregar el producto"
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    if @line_item.destroy && @statement.update_tree_totals
      flash[:notice] = "Producto borrado"
    else
      flash[:danger] = "Ocurrio un error al eliminar el producto"
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update_quantity(update_line_item_quantity_params[:quantity])
      flash[:notice] = "Producto actualizado"
    else
      flash[:danger] = "Ocurrio un error al actualizar el producto"
    end
  end

  def new
    @variant = Variant.find(params[:variant_id])
    @line_item = LineItem.new(statement_id: @statement.id)
  end

  private

  def set_statement
    @statement = Statement.find(params[:statement_id])
  end

  def add_line_item_to_statement
    @variant = Variant.find(params[:variant_id])
    @line_item = @statement.add_line_item(@variant, update_line_item_quantity_params[:quantity].to_i)
  end

  def create_line_item_params
    params.permit(:variant_id, :statement_id)
  end

  def update_line_item_quantity_params
    params.require(:line_item).permit(:quantity)
  end
end

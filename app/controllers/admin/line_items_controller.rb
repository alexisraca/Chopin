class Admin::LineItemsController < ApplicationController
  def create
    @line_item = LineItem.new(line_item_params)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:variant_id, :quantity, :statement_id)
  end
end

class Sales::LineItemsController < ApplicationController

  def create
    @lineitem = LineItem.new(lineitem_params)
    if @lineitem.save
      flash[:notice] = "Producto agregado"
    end
  end

end

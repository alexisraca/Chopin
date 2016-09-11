class Admin::InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all.order(:created_at)
  end

  def new
    @inventory = Inventory.new
  end
  
  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.destroy
      flash[:notice] = "Inventario Borrado"
    end
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      flash[:notice] = "Inventario Guardado"
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    if @inventory.update(inventory_params)
      flash[:notice] = "Inventario Actualizado"
    else
      render :edit
    end
  end

  def inventory_params
    params.require(:inventory).
      permit(:product_id, :quantity, :expiration_date)
  end
end

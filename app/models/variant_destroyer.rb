class VariantDestroyer
  attr_accessor :variant, :product, :error

  def initialize(variant)
    @variant = variant
    @product = variant.product
  end

  def destroy!
    begin
      Variant.transaction do
        if @variant.main_variant?
          remove_full_tree
          @variant.destroy
        else
          @variant.inventories.destroy_all
          @variant.destroy
        end
      end
    rescue ActiveRecord::RecordInvalid => exception
      @error = "Ocurrio un error al borrar el producto"
    end
  end

  private

  def remove_full_tree
    delete_inventories_collection(@product.variants)
    @product.variants.update_all(deleted_at: Time.now)
  end

  def delete_inventories_collection(variants)
    inventories = Inventory.where(variant_id: variants.pluck(:id))
    return if inventories.empty?
    inventories.destroy_all
  end

end
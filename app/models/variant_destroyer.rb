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
          @variant.reload
        else
          @variant.destroy
        end
      end
    rescue ActiveRecord::RecordInvalid => exception
      @error = "Ocurrio un error al borrar el producto"
    end
  end

  private

  def remove_full_tree
    @product.variants.update_all(deleted_at: Time.now)
  end
end
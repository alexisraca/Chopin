module Admin::VariantsHelper
  def variant_id_data_attr(variant)
    return "" if variant.new_record?
    "data-variant-id=#{variant.id}"
  end

  def delete_variant_warning_text(variant)
    if variant.main_variant?
      "¿Esta seguro de que desea dar de baja este producto?, Se daran de baja todas las variantes ya que se trata un producto de linea."
    else
      "¿Esta seguro de que desea dar de baja este producto? se respetara el producto de linea base"
    end
  end

  def variant_count(variant)
    variant.product.variants.common_variants.count
  end

  def restore_variant_text(variant)
    if variant.main_variant?
      "Se restauraran el producto de linea y las variantes ¿Desea continuar?"
    else
      "Se restaurara la variante ¿Desea continuar?"
    end
  end
end

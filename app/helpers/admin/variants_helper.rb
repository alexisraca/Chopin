module Admin::VariantsHelper
  def variant_id_data_attr(variant)
    return "" if variant.new_record?
    "data-variant-id=#{variant.id}"
  end

  def delete_variant_warning_text(variant)
    if variant.main_variant?
      "¿Esta seguro de que desea borrar este producto?, Se borraran todas sus variantes ya que se trata un producto de linea y los respectivos inventarios."
    else
      "¿Esta seguro de que desea borrar este producto?, Se borraran los respectivos inventarios, como es una variante, se respetara el producto de linea base"
    end
  end

  def variant_count(variant)
    variant.product.variants.common_variants.count
  end
end

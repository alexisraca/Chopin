@resetSearchButtons = ->
  @resetDisableableButtons(".submit-search")

@resetDisableableButtons = (selector) ->
  if selector
    $(selector).removeAttr("disabled")
    $(selector).button("reset")
  else
    $(".disableable").removeAttr("disabled")
    $(".disableable").button("reset")

@bindSearchForms = ->
  timer = null
  $("input.keyup-autosearch").keyup ->
    form = $(this).closest "#search-form"
    if timer
      clearTimeout(timer);
    timer = setTimeout( ->
        form.find(".submit-search").button("loading")
        form.submit()
      , 600)

@bindDisableableForms = ->
  $(document).on "ajax:beforeSend click", ".disableable", (e) ->
    form = undefined
    if $(this).is("[disabled]")
      return
    else if $(this).attr("data-target")
      form = $("##{$(this).attr("data-target")}")
    else
      form = $(this).closest "form"

    if form
      form.submit()

    $(this).button("saving")
    $(this).attr("disabled", "disabled")
    
  
  $(document).on "ajax:success", (e) ->
    window.resetDisableableButtons()

$ ->
  window.bindSearchForms()
  window.bindDisableableForms()
  $(".submit-search").on "click", (e) ->
    $(this).button("loading")
    $(this).closest("#search-form").submit()

  $(".submit-fast-products-form").click (e)->
    if $(this).is("[disabled]")
      return
    else
      $(this).button("saving")
      $(this).attr("disabled", "disabled")
      $("#new_fast_product_builder").submit()

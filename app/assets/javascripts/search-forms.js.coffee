@resetSearchButtons = ->
  @resetDisableableButtons($(".submit-search"))

@resetDisableableButtons = (tag) ->
  if tag
    tag.removeAttr("disabled")
    tag.button("reset")
  else
    $(".disableable").removeAttr("disabled")
    $(".disableable").button("reset")

@bindSearchForms = ->
  timer = null
  $(document).on "keyup", "input.keyup-autosearch", (e) ->
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
    button = $(this)
    if $(this).is("[disabled]")
      return false
    else if $(this).attr("data-target")
      form = $("##{$(this).attr("data-target")}")
    else
      form = $(this).closest "form"

    if form
      form.submit()
      $(this).button("saving")
      $(this).attr("disabled", "disabled")
      text = button.html()
      button.html('<i class="fa fa-circle-o-notch fa-spin">')
      $(document).off "ajax:success"
      $(document).on "ajax:success", (e) ->
        window.resetDisableableButtons(button)
        button.html(text)
      return false

    $(this).button("saving")
    $(this).attr("disabled", "disabled")
    text = button.html()
    button.html('<i class="fa fa-circle-o-notch fa-spin">')

    $(document).off "ajax:success"
    $(document).on "ajax:success", (e) ->
      window.resetDisableableButtons(button)
      button.html(text)

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

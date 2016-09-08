@resetSearchButtons = ->
  $(".submit-search").button("reset")

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

$ ->
  window.bindSearchForms()
  $(".submit-search").on "click", (e) ->
    $(this).button("loading")
    $(this).closest("#search-form").submit()


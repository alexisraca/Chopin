@resetSearchButtons = ->
  $(".submit-search").button("reset")

$ ->
  $(".submit-search").on "click", (e) ->
    $(this).button("loading")
    $(this).closest("#search-form").submit()

  $("input.keyup-autosearch").keyup (e) ->
    $(".submit-search").button("loading")
    $(this).closest("#search-form").submit()
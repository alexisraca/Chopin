bindCocoonDatePicker = ->
  $('body').on 'cocoon:after-insert', "form", (e, insertedItem) ->
    window.bindDatePicker($(insertedItem).find(".datepicker"))

@bindDatePicker = (tag)->
  $(tag).datepicker
    todayHighlight: true, 
    orientation: 'auto top', 
    format: 'yyyy-mm-dd'

$ ->
  window.bindDatePicker($(".datepicker"))

  bindCocoonDatePicker()

  $('[data-toggle="tooltip"]').tooltip()

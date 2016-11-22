bindCocoonDatePicker = ->
  $('body').on 'cocoon:before-insert', "form", (e, insertedItem) ->
    $(insertedItem).fadeIn('slow');
  $('body').on 'cocoon:after-insert', "form", (e, insertedItem) ->
    console.log insertedItem
    window.bindDatePicker($(insertedItem).find(".datepicker"))

@bindDatePicker = (tag)->
  $(tag).datepicker
    todayHighlight: true, 
    orientation: 'auto top', 
    format: 'yyyy-mm-dd'

btnFilterActivation = ->
  $(".btn-filter").click (e) ->
    $(".btn-filter").removeClass("btn-filter-active")
    $(e.currentTarget).addClass("btn-filter-active")

$ ->
  window.bindDatePicker($(".datepicker"))

  bindCocoonDatePicker()

  $('[data-toggle="tooltip"]').tooltip()
  
  $(document).click (e) ->
    $(".navigation").removeClass('open-navigation');
  $('.navigation-icon').click (e) ->
    e.stopPropagation();
    $(".navigation").toggleClass('open-navigation');
  
  btnFilterActivation()

  window.rightSidebar = new window.RightSidebar()
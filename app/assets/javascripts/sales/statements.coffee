# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@highlightLineItem = (line_item_id)->
  $(".highlighted-line-item").removeClass("highlighted-line-item") # remover higlight de todos para evitar confusiones
  $("tr[data-line-item-id='#{line_item_id}']").addClass("highlighted-line-item")

  scrollContainer = $("#line-items-list-body")
  scrollPosition = scrollContainer.offset().top
  scrollItem = $("#line-items-list-body .highlighted-line-item")
  
  scrollContainer.animate
    scrollTop: scrollItem.offset().top - scrollContainer.offset().top + scrollContainer.scrollTop() - 20
  , '500', 'swing'

  setTimeout ->
    $(".highlighted-line-item").removeClass("highlighted-line-item");
  , 1000

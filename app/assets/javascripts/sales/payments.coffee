# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@paymentModalBinding = ->
  $("#credit-card-payment").click (e) =>
    e.preventDefault()
    $("#payment-type").val("credit-card")
    @unhideTicket()

  $("#cash-payment").click (e) =>
    e.preventDefault()
    $("#payment-type").val("cash")
    @unhideTicket()

@unhideTicket = ->
  $("#statement-payment-type").hide "fast", "linear", (e)->
    $("#statement-ticket").toggleClass("hidden")

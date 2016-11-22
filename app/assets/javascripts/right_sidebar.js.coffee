class @RightSidebar
  $el: ->
    $("#right-sidebar")
    
  constructor: ->
    $(document).click (e) =>
      if !@$el().find(e.target).length && @$el()[0] != $(e.target)[0]
        @$el().removeClass('open');

  open: ->
    @$el().addClass('open');

  close: ->
    @$el().removeClass('open');
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Lodoss =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    opts =
      lines: 13 # The number of lines to draw
      length: 7 # The length of each line
      width: 4 # The line thickness
      radius: 10 # The radius of the inner circle
      corners: 1 # Corner roundness (0..1)
      rotate: 0 # The rotation offset
      color: "#000" # #rgb or #rrggbb
      speed: 1 # Rounds per second
      trail: 60 # Afterglow percentage
      shadow: false # Whether to render a shadow
      hwaccel: false # Whether to use hardware acceleration
      className: "spinner" # The CSS class to assign to the spinner
      zIndex: 2e9 # The z-index (defaults to 2000000000)
      top: "-330px" # Top position relative to parent in px
      left: "auto" # Left position relative to parent in px

    target = document.getElementById("canvasLoader")
    spinner = new Spinner(opts).spin(target)
    window.app = new Lodoss.Routers.Main()
    $.ajaxSetup(cache: false)
    Backbone.history.start({pushState: true})

    $(document).on "click", "a:not([data-bypass])", (evt) ->
      href = $(@).attr("href")
      protocol = @protocol + "//"
      if href.slice(protocol.length) isnt protocol
        evt.preventDefault()
        window.app.navigate href, true


$(document).ready ->
  Lodoss.init()
class Lodoss.Views.Chat extends Backbone.View

  template: JST["backbone/templates/chat"]

  initialize : ->
    @render()

  events: ->
    "click .chat": "clickChat"
    "mouseover .chat": "mouseoverChat"
    "mouseout .chat": "mouseoutChat"

  render     : ->
    $(@el).html(@template({user: @model.toJSON(), current_user: current_user}))
    @

  clickChat:(e) ->
    window.app.navigate("/messages/chat/" + $(@el).find(".chat").data("id"), true) if !$(e.target).is("img")

  mouseoverChat: ->
    $(@el).find(".chat").css({"background": "#edf1f5"})
    $(@el).find(".chat").css({"border-color": "#DAE1E8"})

  mouseoutChat: ->
    $(@el).find(".chat").css({"background": "white"})
    $(@el).find(".chat").css({"border-color": "white"})
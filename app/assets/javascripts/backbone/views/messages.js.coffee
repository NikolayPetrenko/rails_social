class Lodoss.Views.Messages extends Backbone.View

  el: "#dialog"

  initialize: ->
    @render()
    @collection.bind "add", @renderMessage, @

  renderMessage: (message) ->
    if message.attributes.chat isnt undefined
      $("#chat-box").find('h3').html("Messages with " + message.attributes.chat.firstname + ':')
    messageView = new Lodoss.Views.Message(model: message)
    $(@el).append(messageView.render().el)

  render: ->
    if @collection.length > 0
      @collection.each @renderMessage, @

class Lodoss.Views.Chats extends Backbone.View

  el: "#user-box"

  initialize: ->
    @render()

  renderChat: (chat) ->
    chatView = new Lodoss.Views.Chat(model: chat)
    $(@el).append(chatView.render().el)

  render: ->
    if @collection.length > 0
      @collection.each @renderChat, @

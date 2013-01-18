class Lodoss.Views.Friends extends Backbone.View

  el: "#list-friends"

  initialize: ->

  renderFriend: (user) ->
    friendView = new Lodoss.Views.Friend(model: user)
    $(@el).append(friendView.render().el)

  render: ->
    if @collection.length > 0
      @collection.each @renderFriend, @
      $(@el).show()
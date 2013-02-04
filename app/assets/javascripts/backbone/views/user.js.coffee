class Lodoss.Views.User extends Backbone.View

  el: $("#user-box")

  template: JST["backbone/templates/user"]

  initialize: ->
    @render()
    $('#canvasLoader').show()

  render: ->
    user = @model.toJSON()
    $(@el).html(@template({user: user, current_user: current_user}))
    view_form_comment = new Lodoss.Views.FormComment(model: new Lodoss.Models.Comment())
    view_form_comment.render(user.id)
    @renderComments(user.id)
    @renderFriends(user.id)
    if parseInt(current_user) is user.id
      @renderPendingFriends(user.id)
#    @realtimeRenderComment(user.id)
    @realtimeDeleteComment(user.id)
    $("input[type='search']").val('')

  renderComments:(side) ->
    window.comments     = new Lodoss.Collections.Comments()
    window.comments.url = "/comments/side/" + side
    window.comments.fetch
      success: ->
        new Lodoss.Views.Comments(collection: comments)
      error: ->

  renderFriends:(user) ->
    friends     = new Lodoss.Collections.Users()
    friends.url = "/users/friends/" + user
    friends.fetch
      success: ->
        view_friends = new Lodoss.Views.Friends(collection: friends)
        view_friends.render()
        $('#canvasLoader').hide()
      error: ->

  renderPendingFriends:(user) ->
    pending_friends     = new Lodoss.Collections.Users()
    pending_friends.url = "/users/pending/" + user
    pending_friends.fetch
      success: ->
        view_pending_friends    = new Lodoss.Views.Friends(collection: pending_friends)
        view_pending_friends.el = "#list-pending-friends"
        view_pending_friends.render()
      error: ->

  realtimeRenderComment: (side) ->
    window.pusher  = new Pusher("4624f11f824b9e6718ef")
    channel = window.pusher.subscribe("comment_for_" + side.toString())
    channel.bind "new-comment", (data) ->
      if data.user.id isnt parseInt(current_user)
        soundManager.play("new_comment")
        model = new Lodoss.Models.Comment()
        model.attributes         = data.user
        model.attributes.text    = data.comment.text
        model.attributes.side_id = data.comment.side_id
        model.attributes.id      = data.comment.id
        model.set({ id: data.comment.id })
        window.comments.add(model)
        window.comments.reset()

  realtimeDeleteComment: (side) ->
    pusher  = new Pusher("4624f11f824b9e6718ef")
    channel = pusher.subscribe("delete_comment_from_" + side.toString())
    channel.bind "delete-comment", (data) ->
      if data.user.id isnt parseInt(current_user)
        $("[data-id = "+data.comment.id+"]").parent().remove()
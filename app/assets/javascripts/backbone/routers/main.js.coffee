class Lodoss.Routers.Main extends Backbone.Router

  routes:
    "users/:id"           : "index"
    "users/search/:query" : "search"
    "messages/chat/:id"   : "dialog"
    "messages"            : "chat"

  index: (id) ->
    $("#chat-box").empty()
    $("#form-message").empty()
    user = new Lodoss.Models.User({id: id})
    user.fetch
      success: ->
        new Lodoss.Views.User({model: user})
        $(".search-box").empty()
      error: ->

  search: (query) ->
    query = _(query).strip()
    if !_(query).empty()
      $(".search-box").empty()
      $("#chat-box").empty()
      $("#form-message").empty()
      search_users = new Lodoss.Collections.Users()
      search_users.url = "/users/search/" + query
      search_users.fetch
        success: ->
          $("#user-box").empty()
          view_search_user = new Lodoss.Views.Friends(collection: search_users)
          view_search_user.el = "#user-box"
          view_search_user.render()
          $('input[type="search"]').val(query)
          $('#canvasLoader').hide()
        error: ->

  dialog: (id) ->
    $("#user-box").empty()
    $("#chat-box").addClass("six columns centered").html("<h3>Messages:</h3>")
    $("#chat-box").append("<div id='dialog'></div>")
    @newMessageReaitime(id)
    @deleteMessageRealtime(id)
    if window.view_form_message is undefined
      window.view_form_message = new Lodoss.Views.FormMessage(model: new Lodoss.Models.Message())
    window.view_form_message.render(id)
    window.messages     = new Lodoss.Collections.Messages()
    window.messages.url = "/messages/chat/" + id
    window.messages.fetch
      success: ->
        new Lodoss.Views.Messages(collection: messages)
        window.scrollTo(0, document.body.scrollHeight);
      error: ->

  chat: () ->
    $("#chat-box").empty()
    $("#form-message").empty()
    $("#user-box").html("<h3>Messages with:</h3> ")
    window.chats     = new Lodoss.Collections.Messages()
    window.chats.url = "/messages"
    window.chats.fetch
      success: ->
        new Lodoss.Views.Chats(collection: chats)
      error: ->

  newMessageReaitime: (id) ->
    pusher  = new Pusher("4624f11f824b9e6718ef")
    channel = pusher.subscribe("message_for_" + current_user.toString() + "_" + id.toString())
    channel.bind "new-message", (data) ->
      soundManager.play("new_message", {volume: 50})
      model = new Lodoss.Models.Message()
      model.attributes           = data.user
      model.attributes.text      = data.message.text
      model.attributes.id        = data.message.id
      model.attributes.datetime  = data.message.datetime
      model.set({ id: data.message.id })
      window.messages.add(model)
      window.messages.reset()

  deleteMessageRealtime: (id) ->
    pusher  = new Pusher("4624f11f824b9e6718ef")
    channel = pusher.subscribe("delete_message_for_" + current_user.toString() + "_" + id.toString())
    channel.bind "delete-message", (data) ->
      $("[data-id = "+data.message.id+"]").parent().remove()
class Lodoss.Routers.Main extends Backbone.Router

  routes:
    "users/:id"           : "index"
    "users/search/:query" : "search"
    "messages/:id"        : "messages"

  index: (id) ->
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

  messages: (id) ->
    alert "Sorry. Section is under development."
    window.app.navigate("users/" + id)
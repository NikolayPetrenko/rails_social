users =

  init: ->
    do @addFriend
    do @removeFriend
    do @searchInit

  addFriend: ->
    $(".add-friend").live "click", (e) ->
      e.preventDefault()
      users.actionFromFriend($(@), "add")

  removeFriend: ->
    $(".remove-friend").live "click", (e) ->
      e.preventDefault()
      users.actionFromFriend($(@), "remove")

  actionFromFriend: (el, action) ->
    $('#canvasLoader').show()
    $.ajax
      url: "/users/actionFriend"
      type: "POST"
      data:
        id: el.data('user')
        act: action
      dataType: "json"
      success: (res) ->
        user = new Lodoss.Models.User({id: el.data('user')})
        user.fetch
          success: ->
            $('#canvasLoader').hide()
            new Lodoss.Views.User({model: user})

  searchInit: ->
    $('.search').on "click", (e) ->
      e.preventDefault()
      if !$(@).is("li")
        search = $(@).parents('ul').find('form').find('input[type="search"]')
        query = _((search).val()).strip()
        if !_(query).empty()
          $('#canvasLoader').show()
          $("#chat-box").empty()
          $("#form-message").empty()
          users.search query

#  searchAutocomplete: ->
#    $('input[type="search"]').on "keyup", (e) ->
#      e.preventDefault()
#      query = _($(@).val()).strip()
#      if !_(query).empty()
#        $(".search-box").empty()
#        query_users = new Lodoss.Collections.Users()
#        query_users.url = "/users/search/" + query
#        query_users.fetch
#          success: ->
#            view_search_user = new Lodoss.Views.Friends(collection: query_users)
#            view_search_user.el = ".search-box"
#            view_search_user.render()
#          error: ->

  search: (query) ->
    query_users = new Lodoss.Collections.Users()
    query_users.url = "/users/search/" + query
    query_users.fetch
      success: ->
        $("#user-box").empty()
        $(".search-box").empty()
        view_search_user = new Lodoss.Views.Friends(collection: query_users)
        view_search_user.el = "#user-box"
        view_search_user.render()
        $(view_search_user.el).html('Search returned no results') if view_search_user.options.collection.length == 0
        window.app.navigate("users/search/" + query)
        $('#canvasLoader').hide()
      error: ->

$(document).ready ->
  do users.init

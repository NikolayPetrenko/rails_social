class Lodoss.Views.Comments extends Backbone.View

  el: "#comments"

  initialize: ->
    @render()
    @collection.bind "add", @renderComment, @

  renderComment: (comment) ->
    commentView = new Lodoss.Views.Comment(model: comment)
    $(@el).append(commentView.render().el)

  render: ->
    if @collection.length > 0
      @collection.each @renderComment, @

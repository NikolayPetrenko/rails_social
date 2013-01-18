class Lodoss.Views.Comment extends Backbone.View

  template: JST["backbone/templates/comment"]

  events: ->
    "click .remove-comment": "destroy"

  initialize : ->
    @render()

  render     : ->
    $(@el).html(@template({user: @model.toJSON(), current_user: current_user}))
    @

  destroy: (e) ->
    $('#canvasLoader').show()
    e.preventDefault()
    self = @
    @model.destroy
      success: ->
        self.remove()
        $('#canvasLoader').hide()
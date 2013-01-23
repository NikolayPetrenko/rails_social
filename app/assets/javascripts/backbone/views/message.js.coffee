class Lodoss.Views.Message extends Backbone.View

  template: JST["backbone/templates/message"]

  events: ->
    "click .remove-message": "destroy"

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
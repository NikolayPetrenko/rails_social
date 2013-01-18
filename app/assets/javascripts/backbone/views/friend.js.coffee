class Lodoss.Views.Friend extends Backbone.View

  template: JST["backbone/templates/friend"]

  initialize : ->
    @render()


  render     : ->
    $(@el).html(@template({user: @model.toJSON()}))
    @
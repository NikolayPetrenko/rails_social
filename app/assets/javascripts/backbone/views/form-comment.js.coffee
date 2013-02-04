class Lodoss.Views.FormComment extends Backbone.View
  template: JST["backbone/templates/form-comment"]
  el: "#form-comment"

  render: (id) ->
    @model.attributes.side_id = id
    $(@el).html(@template({user: @model.toJSON()}))
    @

  events: ->
    "submit form": "save"

  save: (e) ->
    e.preventDefault()
    $('#canvasLoader').show()
    $(@el).find(".button").attr('disabled', true);
    @model = new Lodoss.Models.Comment()
    data =
      text:    $("#comment_text").val()
      user_id: current_user
      side_id: $("#comment_side_id").val()
      pid:     0
    self = @
    if !_(_(data.text).strip()).empty()
      data.text = data.text.replace /(http|https):\/\/[\w\.\-]+\b/g, (a) -> "<a data-bypass=\"true\" href=\"" + a + "\" target=\"_blank\">" + a + "</a>"
      @model.save data,
        success: (model, resp) ->
          self.model.attributes.avatar    = resp.user.avatar
          self.model.attributes.firstname = resp.user.firstname
          self.model.attributes.lastname  = resp.user.lastname
          self.model.attributes.id        = resp.comment.id
          self.model.set({ id: resp.comment.id })
          window.comments.add(self.model)
          window.comments.reset()
          $(self.el).find("#comment_text").val('')
          $('#canvasLoader').hide()
          $(self.el).find(".button").attr('disabled', false);

class Lodoss.Views.FormMessage extends Backbone.View
  template: JST["backbone/templates/form-message"]
  el: "#form-message"

  render: (id) ->
    @model.attributes.receiver_id = id
    $(@el).html(@template({user: @model.toJSON()}))
    @

  events: ->
    "submit form": "save"

  save: (e) ->
    e.preventDefault()
    $("#canvasLoader").show()
    $(@el).find(".button").attr('disabled', true);
    @model.clear();
    data =
      text        : $("#message_text").val()
      user_id     : current_user
      receiver_id : $("#message_receiver_id").val()
    self = @
    if !_(_(data.text).strip()).empty()
      data.text = data.text.replace /(http|https):\/\/[\w\.\-]+\b/g, (a) -> "<a data-bypass=\"true\" href=\"" + a + "\" target=\"_blank\">" + a + "</a>"
      @model.save data,
        success: (model, resp) ->
          self.model.attributes.avatar    = resp.user.avatar
          self.model.attributes.firstname = resp.user.firstname
          self.model.attributes.lastname  = resp.user.lastname
          self.model.attributes.id        = resp.message.id
          self.model.attributes.datetime  = resp.message.datetime
          self.model.set({ id: resp.message.id })
          window.messages.add(self.model)
          window.messages.reset()
          $(self.el).find("#message_text").val('')
          $('#canvasLoader').hide()
          $(self.el).find(".button").attr('disabled', false);
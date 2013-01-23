#-------------- Model ----------------#
class Lodoss.Models.Message extends Backbone.Model

  defaults:
    text        : ""
    user_id     : ""
    receiver_id : ""
    firstname   : ""
    lastname    : ""
    avatar      : ""

  url: ->
    if @isNew() then "/messages" else "/messages/" + @id

#------------ Collection -------------#
class Lodoss.Collections.Messages extends Backbone.Collection

  model: Lodoss.Models.Message
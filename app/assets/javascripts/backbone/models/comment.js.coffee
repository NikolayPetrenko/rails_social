#-------------- Model ----------------#
class Lodoss.Models.Comment extends Backbone.Model

  defaults:
    text    : ""
    user_id : ""
    side_id : ""
    pid     : ""
    firstname     : ""
    lastname     : ""
    avatar: ""

  url: ->
    if @isNew() then "/comments" else "/comments/" + @id

#------------ Collection -------------#
class Lodoss.Collections.Comments extends Backbone.Collection

  model: Lodoss.Models.Comment
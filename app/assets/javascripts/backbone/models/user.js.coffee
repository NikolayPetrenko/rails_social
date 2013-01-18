#-------------- Model ----------------#
class Lodoss.Models.User extends Backbone.Model

  defaults:
    login     : ""
    email     : ""
    firstname : ""
    lastname  : ""

  url: ->
    (if @isNew() then "/users" else "/users/" + @id)


#------------ Collection -------------#
class Lodoss.Collections.Users extends Backbone.Collection

  model: Lodoss.Models.User
  url: "/users"
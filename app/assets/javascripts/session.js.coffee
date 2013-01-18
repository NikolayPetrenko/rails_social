validates = 

  init: ->
    do @forgotToPassword
    do @newPassword
    do @login
    do @signup

  forgotToPassword: ->
    form = $ '#forgot-password'
    form.validate
      rules:
        'forgot[email]':
          required: true
          email: true
      messages:
        'forgot[email]':
          required: 'Enter email'
          email: 'Enter email and not another'

  newPassword: ->
    form = $ '#new-password'
    form.validate
      rules:
        'new[password]':
          required: true
          minlength: '6'
        'new[password_confirmation]':
          equalTo: '#new_password'
      messages:
        'new[password]':
          required: 'Enter new password'
          minlength: 'The password must be at least 6 characters'
        'new[password_confirmation]':
          equalTo: 'Repeat password'

  login: ->
    form = $ '#login'
    form.validate
      rules:
        'session[login]':
          required: true
        'session[password]':
          required: true
      messages:
        'session[login]':
          required: 'Enter login'
        'session[password]':
          required: 'Enter password'

  signup: ->
    form = $ '#signup'
    form.validate
      rules:
        'user[login]':
          required: true
        'user[email]':
          required: true
          email: true
        'user[firstname]':
          required: true
        'user[lastname]':
          required: true
        'user[password]':
          required: true
          minlength: '6'
        'user[password_confirmation]':
          equalTo: '#user_password'
      messages:
        'user[login]':
          required: 'Enter login'
        'user[email]':
          required: 'Enter email'
          email: 'Enter email and not another'
        'user[firstname]':
          required: 'Enter firstname'
        'user[lastname]':
          required: 'Enter lastname'
        'user[password]':
          required: 'Enter new password'
          minlength: 'The password must be at least 6 characters'
        'user[password_confirmation]':
          equalTo: 'Repeat password'

$(document).ready ->
  do validates.init
validates = 

  init: ->
    do @forgotToPassword
    do @newPassword
    do @login
    do @signup
    do @sliderInit

  sliderInit: ->
    $("#slider").orbit
      animation: "vertical-slide" # fade, horizontal-slide, vertical-slide, horizontal-push
      animationSpeed: 800 # how fast animtions are
      timer: true # true or false to have the timer
      advanceSpeed: 4000 # if timer is enabled, time between transitions
      pauseOnHover: false # if you hover pauses the slider
      startClockOnMouseOut: true # if clock should start on MouseOut
      startClockOnMouseOutAfter: 1000 # how long after MouseOut should the timer start again
      directionalNav: true # manual advancing directional navs
      captions: true # do you want captions?
      captionAnimation: "slideOpen" # fade, slideOpen, none
      captionAnimationSpeed: 800 # if so how quickly should they animate in
      bullets: false # true or false to activate the bullet navigation
      bulletThumbs: false # thumbnails for the bullets
      bulletThumbLocation: "" # location from this file where thumbs will be
      afterSlideChange: -> # empty function

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
        'session[email]':
          required: true
        'session[password]':
          required: true
      messages:
        'session[email]':
          required: 'Enter email'
        'session[password]':
          required: 'Enter password'

  signup: ->
    form = $ '#signup'
    form.validate
      rules:
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
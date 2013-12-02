class Daltoniam.Views.BlogPostView extends Backbone.View
  template: HoganTemplates['blogPost']
  el: "#app"

  events: 
    "click .blogPostMain" : "goHome"
    "click .signin" : "goSignin"
    "click .signup" : "goSignup"
    "click .signout" : "goSignout"
    'submit #signinForm'   : 'register'
    'submit #signUpForm'   : 'registerSignUp'
    #"click .signinModalBtn" : "goLogin"

  initialize: (param) ->
    @model = new Daltoniam.Models.Post(param)
    @listenTo @model, 'change', @render, this
    @model.fetch(reset: true) #success: -> render()

  render: ->
    @$el.html @template.render(@model.attributes)
    height = $('.blogPostTitle').height()
    if height < 100
       $('.blogPostTitle').css("margin-top", "80px")
    else if height < 200
       $('.blogPostTitle').css("margin-top", "40px")
    if @model.attributes.comment_count == 0
      $('.commentTitle').html("No Comments")
    else if @model.attributes.comment_count == 1
      $('.commentTitle').html("1 Comment")

    #loop through the comments array and append them to the UI

    this.doCommentCheck()
    editor = new MediumEditor('.editable', buttons: ['bold','italic','underline','anchor','header1','header2','quote','pre','unorderedlist'])

  doCommentCheck: ->
    userRole = $.cookie('role')
    if userRole
      commentView = new Daltoniam.Views.AddCommentView(model: @model)
      $('.addComment').html commentView.render()
    else
      $('.addComment').html "<p class='postText'><span class='anchorText signin'>Sign in</span> or <span class='anchorText signup'>Sign up</span> to comment</p>"

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $(".blogPostContent").removeClass("bounceInRight").addClass('bounceOutRight')
    $('.blogPostContent').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', () -> inceptionRouter.navigate("blog", trigger: true))

  goSignin: ->
    $('#signInModal').modal('show')

  goSignup: ->
    $('#signUpModal').modal('show')

  goSignout: ->
    $.removeCookie('role');
    $.ajax({
    url: '/1/sessions',
    type: 'DELETE'
    })
    this.doCommentCheck()

  register: (e) ->
    e.preventDefault()
    $.post('/1/sessions', @$('#signinForm').serialize())
      .done((data) =>
        this.goLogin(data)
        $('#signInModal').modal('hide')

      )
      .fail((data) =>
        $('#signInModal').modal('hide')
        this.loginFailed()
      )

  registerSignUp: (e) ->
    e.preventDefault()
    $.post('/1/users', @$('#signUpForm').serialize())
      .done((data) =>
        this.goLogin(data)
        $('#signUpModal').modal('hide')
      )
      .fail((data) =>
        $('#signUpModal').modal('hide')
        this.loginFailed()
      )

  loginFailed: ->
    #do some kind of login failure here
    console.log "Bummer some cool error handling here."

  goLogin: (data) ->
    $.cookie('role', data.response.role)
    this.doCommentCheck()
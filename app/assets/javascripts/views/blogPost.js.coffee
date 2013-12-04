class Daltoniam.Views.BlogPostView extends Backbone.View
  template: HoganTemplates['blogPost']
  el: "#app"

  events: 
    "click .blogPostMain" : "goHome"
    "click .signin" : "goSignin"
    "click .signup" : "goSignup"
    "click .signout" : "goSignout"
    "click .editPost" : "goEditPost"
    "click .deletePost" : "goDeletePost"
    'submit #signinForm'   : 'register'
    'submit #signUpForm'   : 'registerSignUp'
    'submit #commentForm' : 'addComment'
    #"click .signinModalBtn" : "goLogin"

  initialize: (param) ->
    $(@el).unbind("click")
    console.log "param is: #{param}"
    console.dir param
    @model = new Daltoniam.Models.Post(param)
    @listenTo @model, 'change', @render, this
    @model.fetch(reset: true) #success: -> render()

  render: ->
    @$el.html @template.render(@model.attributes)
    height = $('.blogPostTitle').height()
    width = $('.row').width()
    top = 0
    offset = 0
    if width < 1000
      offset = 400

    if height < 100
      total = offset + 80
      $('.blogPostTitle').css("margin-top", "#{total}px")
    else if height < 200
        total = offset + 40
        $('.blogPostTitle').css("margin-top", "#{total}px")

    if @model.attributes.comment_count == 0
      $('.commentTitle').html("No Comments")
    else if @model.attributes.comment_count == 1
      $('.commentTitle').html("1 Comment")

    userRole = $.cookie('role')
    if userRole and userRole == 'admin'
      $('.blogPostHeader').append "<p class='postText'><span class='anchorText editPost'>Edit Post</span> or <span class='anchorText deletePost'>Delete Post</span> </p>"

    #loop through the comments array and append them to the UI
    for comment in @model.attributes.comments
      view = new Daltoniam.Views.CommentView(comment)
      $('.comments').append view.render()

    this.doCommentCheck()

  doCommentCheck: ->
    userRole = $.cookie('role')
    console.log "user role is: #{userRole}"
    if userRole
      commentView = new Daltoniam.Views.AddCommentView(model: @model)
      $('.addComment').html commentView.render()
    else
      $('.addComment').html "<p class='postText'><span class='anchorText signin'>Sign in</span> or <span class='anchorText signup'>Sign up</span> to comment</p>"
    editor = new MediumEditor('.editable', buttons: ['bold','italic','underline','anchor','header1','header2','quote','pre','unorderedlist'])

  addComment: (e) ->
    e.preventDefault()
    markdown = html2markdown(@$('.editable').html())
    @$('.editable').html("")
    $.post("/1/posts/#{@model.attributes.id}/comments", text: markdown)
      .done((data) =>
        view = new Daltoniam.Views.CommentView(data.response)
        $('.comments').append view.render()
      )
      .fail((data) =>
        console.log "failure message here"
      )

  goEditPost: ->
    inceptionRouter.navigate("blog/#{@model.attributes.id}/edit", trigger: true)

  goDeletePost: ->
    if confirm('Are you sure you want to delete this post?')
      $.ajax({
      url: "/1/posts/#{@model.attributes.id}",
      type: 'DELETE'
      })
      inceptionRouter.navigate("blog", trigger: true)


  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $(".comments").removeClass("bounceInLeft").addClass('bounceOutLeft')
    $(".addComment").removeClass("fadeInUp").addClass('fadeOutUp')
    $(".commentContent").removeClass("bounceInLeft").addClass('bounceOutLeft')
    $(".blogPostContent").removeClass("bounceInRight").addClass('bounceOutRight')
    $('.blogPostContent').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', () -> inceptionRouter.navigate("blog", trigger: true))

  goSignin: ->
    $('#signInModal').modal('show')

  goSignup: ->
    $('#signUpModal').modal('show')

  goSignout: ->
    console.log "no more user"
    $.removeCookie('role', { path: '/' })
    $.removeCookie('role')
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
          $('#alert-messages-signup').html('<div class="alert alert-danger alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <p>Error: Invalid username or password</p>
        </div>')
      )

  registerSignUp: (e) ->
    e.preventDefault()
    $.post('/1/users', @$('#signUpForm').serialize(),dataType: 'json')
      .done((data) =>
        this.goLogin(data)
        $('#signUpModal').modal('hide')
      )
      .fail((data) =>
        response = JSON.parse(data.responseText)
        errors = ""
        errors += this.getErrors("email",response.messages)
        errors += this.getErrors("name",response.messages)
        errors += this.getErrors("password",response.messages)
        $('#alert-messages').html("<div class='alert alert-danger alert-dismissable'>
        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
        <p>Errors:</p>
        #{errors}
        </div>")
      )

  getErrors: (errorKey, messages) ->
    errs = messages[errorKey]
    collect = ""
    if errs
      for error in errs
        collect += "<p>#{errorKey}: #{error}</p>"
    collect

  goLogin: (data) ->
    $.cookie('role', data.response.role)
    this.doCommentCheck()
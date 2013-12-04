class Daltoniam.Views.NewPostView extends Backbone.View
  template: HoganTemplates['newpost']
  el: "#app"

  events: 
    "click .cancelLink"  : "goHome"
    'submit #newPostForm': 'addPost'
    "click .signin" : "goSignin"
    'submit #signinForm'   : 'register'

  initialize: (attribs) ->
    $(@el).unbind("click")
    console.dir attribs
    if attribs
      @model = new Daltoniam.Models.Post(attribs)
      @listenTo @model, 'change', @render, this
      @model.fetch(reset: true) #success: -> render()

  render: ->
    if @model
      @$el.html @template.render(@model.attributes)
      $(".createBtn").html("Edit Post")
      $(".mainHeader").html("Edit Post")
    else
      @$el.html @template.render()
      userRole = $.cookie('role')
      if not userRole
        $('.mainHeader').append "<p class='postText'><span class='anchorText signin'>Sign in</span></p>"
    editor = new MediumEditor('.editable', buttons: ['bold','italic','underline','anchor','header1','header2','quote','pre','unorderedlist'])
    #$('.editable').mediumImages(uploadScript: '/1/upload') need to create a route for uploading images

  addPost: (e) ->
    console.log "add a new post"
    e.preventDefault()
    type = 'POST'
    url = '/1/posts'
    content = html2markdown(@$('#contentBox').html())
    preview = html2markdown(@$('#previewBox').html())
    values = post: {title: @$('input').val(), text: content, preview: preview }

    if @model
      values['id'] = @model.attributes.id
      type = 'PUT'
      url = "#{url}/#{@model.attributes.id}"

    $.ajax({
    url: url,
    type: type,
    data: values,
    success: (response) =>
      @goHome()
    })

  goHome: ->
    if @model
      inceptionRouter.navigate("blog/#{@model.attributes.id}", trigger: true)
    else
      inceptionRouter.navigate("blog", trigger: true)

  goSignin: ->
    $('#signInModal').modal('show')

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

  goLogin: (data) ->
    $.cookie('role', data.response.role)

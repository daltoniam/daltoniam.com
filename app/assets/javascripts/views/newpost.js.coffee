class Daltoniam.Views.NewPostView extends Backbone.View
  template: HoganTemplates['newpost']
  el: "#app"

  events: 
    "click .cancelLink"  : "goHome"
    'submit #newPostForm': 'addPost'

  initialize: (attribs) ->
    console.dir attribs
    if attribs
      @model = new Daltoniam.Models.Post(attribs)
      @listenTo @model, 'change', @render, this
      @model.fetch(reset: true) #success: -> render()

  render: ->
    if @model
      @$el.html @template.render(@model.attributes)
      $(".createBtn").html("Edit Post")
      $("h3").html("Edit Post")
    else
      @$el.html @template.render()
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

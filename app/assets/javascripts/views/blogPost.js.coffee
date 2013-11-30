class Daltoniam.Views.BlogPostView extends Backbone.View
  template: HoganTemplates['blogPost']
  el: "#app"

  #events: 
  #  "click .blogMain" : "goHome"

  initialize: (param) ->
    @model = new Daltoniam.Models.Post(param)
    @listenTo @model, 'change', @render, this
    @model.fetch(reset: true) #success: -> render()

  render: ->
    console.log("render the blog post")
    console.dir(@model)
    console.log("val: #{@model.text}")
    @$el.html @template.render()
    post = new Daltoniam.Views.PostView(model: @model)
    $('.posts').append post.render()
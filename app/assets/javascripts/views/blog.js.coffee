class Daltoniam.Views.BlogView extends Backbone.View
  template: HoganTemplates['blog']
  el: "#app"

  events: 
    "click .blogMain" : "goHome"
    "click .newPost"  : "newPost"

  initialize: ->
    @collection = new Daltoniam.Collections.Posts()
    @listenTo @collection, 'add remove reset', @render, this
    @collection.fetch(reset: true)
    @firstRender = false

  render: ->
    if not @firstRender
      @firstRender = true
      @$el.html @template.render()
      userRole = $.cookie('role')
      if userRole and userRole == 'admin'
        $('.postHeader').append "<p class='postText'><span class='anchorText newPost'>New Post</span> </p>"

    @addAll()

    $(window).scroll( =>
      if $(window).scrollTop() + $(window).height() > $(document).height() - 100
        @nextPage()
    )


  addAll: ->
    @collection.forEach(@addOne,this)

  addOne: (item)->
    post = new Daltoniam.Views.PostView(model: item)
    $('.posts').append post.render()

  newPost: ->
    inceptionRouter.navigate("blog/new", trigger: true)

  nextPage: ->
    if @collection.next and @collection.next <= @collection.count
      console.log "fetch that ... #{@collection.next}"
      @collection.fetch(data: {page: @collection.next})

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.blogCircle').css("background": "#8e44ad")
    $('.postHeader').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.posts').removeClass('bounceInUp').addClass('bounceOutDown')
    width = $('.blogMain').width() + 30
    height = $('.blogMain').height() - 20
    pixelStr = "#{height}"
    $('.blogMain').transition(x: "#{width}", delay: 600).transition(y: pixelStr, complete: -> inceptionRouter.navigate("home/blog", trigger: true))




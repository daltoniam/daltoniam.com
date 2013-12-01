class Daltoniam.Views.BlogPostView extends Backbone.View
  template: HoganTemplates['blogPost']
  el: "#app"

  events: 
    "click .blogPostMain" : "goHome"

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

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $(".blogPostContent").removeClass("bounceInRight").addClass('bounceOutRight')
    $('.blogPostContent').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', () -> inceptionRouter.navigate("blog", trigger: true))
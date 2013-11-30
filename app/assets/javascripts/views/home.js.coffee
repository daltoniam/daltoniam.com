class Daltoniam.Views.HomeView extends Backbone.View
  template: HoganTemplates['home']
  el: "#app"

  events: 
    "click .blogCircle" : "goBlog"
    "click .resumeCircle" : "goResume"
    "click .aboutCircle" : "goAbout"
    "click .projectCircle" : "goProject"

  initialize: (param) ->
    @returnParam = param['name']

  render: ->
    @$el.html @template.render()
    if @returnParam == 'blog'
      $('.blogBubble').removeClass('bounceInUp')
    else if @returnParam == 'resume'
      $('.resumeBubble').removeClass('bounceInRight')

  goBlog: ->
    $('.blogCircle').css("background": "#8e44ad")
    $('.resumeBubble').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.bounceInRight').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.bounceInLeft').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.githubBubble').removeClass('bounceInUp').addClass('bounceOutDown')
    $('.linkedinBubble').removeClass('bounceInUp').addClass('bounceOutDown')
    $('.bounceInDown').removeClass('bounceInDown').addClass('bounceOutUp')
    width = $('.blogBubble').width() + 30
    height = $('.blogBubble').height() - 20
    pixelStr = "-#{height}"
    delayTime = 500
    $('.blogBubble').removeClass('bounceInUp').transition(
      y: pixelStr
      delay: delayTime
    ).transition(x: "-#{width}",complete: -> inceptionRouter.navigate("blog", trigger: true))

  goResume: ->
    $('.resumeCircle').css("background": "#C0392B")
    $('.blogBubble').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.mainTextBody').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.twitterBubble').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.contactBubble').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.linkedinBubble').removeClass('bounceInRight').addClass('bounceOutDown')
    $('.bounceInLeft').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.bounceInUp').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.bounceInDown').removeClass('bounceInDown').addClass('bounceOutUp')
    width = $('.resumeBubble').width() + 30
    width = width*2
    height = $('.resumeBubble').height() - 20
    pixelStr = "-#{height}"
    delayTime = 500
    $('.resumeCircle').removeClass('bounceInRight').transition(
      y: pixelStr
      delay: delayTime
    ).transition(x: "-#{width}",complete: -> inceptionRouter.navigate("resume", trigger: true))

  goAbout: ->
    $('.aboutCircle').css("background": "#16a085")
    $('.bounceInRight').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.bounceInUp').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.projectBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.stackBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.bounceInDown').removeClass('bounceInDown').addClass('bounceOutUp')
    height = $('.aboutBubble').height() - 20
    pixelStr = "-#{height}"
    delayTime = 500
    $('.aboutCircle').removeClass('bounceInRight').transition(
      y: pixelStr
      delay: delayTime
      complete: -> inceptionRouter.navigate("about", trigger: true)
    )

  goProject: ->
    $('.projectCircle').css("background": "#2c3e50")
    $('.bounceInRight').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.bounceInUp').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.aboutBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.stackBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.bounceInDown').removeClass('bounceInDown').addClass('bounceOutUp')
    height = $('.projectBubble').height() - 20
    height = height*2
    pixelStr = "-#{height}"
    delayTime = 500
    $('.projectCircle').removeClass('bounceInRight').transition(
      y: pixelStr
      delay: delayTime
      complete: -> inceptionRouter.navigate("project", trigger: true)
    )


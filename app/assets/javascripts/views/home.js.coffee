class Daltoniam.Views.HomeView extends Backbone.View
  template: HoganTemplates['home']
  el: "#app"

  events: 
    #"click .blogCircle" : "goBlog"
    "click .resumeCircle" : "goResume"
    "click .aboutCircle" : "goAbout"
    "click .projectCircle" : "goProject"

  initialize: (param) ->
    $(@el).unbind("click")
    @returnParam = param['name']

  render: ->
    @$el.html @template.render()
    if @returnParam == 'blog'
      $('.blogBubble').removeClass('bounceInUp')
    else if @returnParam == 'resume'
      $('.resumeBubble').removeClass('bounceInRight')
    else if @returnParam == 'about'
      $('.aboutBubble').removeClass('bounceInLeft')
    else if @returnParam == 'project'
      $('.projectBubble').removeClass('bounceInLeft')

  goBlog: ->
    $('.blogCircle').css("background": "#8e44ad")
    $('.resumeBubble').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.aboutBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.projectBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')

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
    $('.aboutBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.projectBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    
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
    console.log "about is done"
    $('.aboutCircle').css("background": "#16a085")
    $('.blogBubble').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.resumeBubble').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.projectBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')

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
    $('.aboutBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.blogBubble').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.resumeBubble').removeClass('bounceInRight').addClass('bounceOutRight')

    $('.bounceInRight').removeClass('bounceInRight').addClass('bounceOutRight')
    $('.bounceInUp').removeClass('bounceInUp').addClass('bounceOutUp')
    $('.aboutBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.stackBubble').removeClass('bounceInLeft').addClass('bounceOutLeft')
    $('.bounceInDown').removeClass('bounceInDown').addClass('bounceOutUp')
    height = $('.projectBubble').height()
    height = height*2 - 20
    pixelStr = "-#{height}"
    delayTime = 500
    $('.projectCircle').removeClass('bounceInRight').transition(
      y: pixelStr
      delay: delayTime
      complete: -> inceptionRouter.navigate("project", trigger: true)
    )


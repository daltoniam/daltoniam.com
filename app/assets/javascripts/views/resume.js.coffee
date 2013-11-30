class Daltoniam.Views.ResumeView extends Backbone.View
  template: HoganTemplates['resume']
  el: "#app"

  events: 
    "click .resumeMain" : "goHome"

  render: ->
    @$el.html @template.render()

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.resumeCircle').css("background": "#C0392B")
    $('.postHeader').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.posts').removeClass('bounceInUp').addClass('bounceOutDown')
    width = $('.resumeMain').width() + 30
    width = width*2
    height = $('.resumeMain').height() - 20
    pixelStr = "#{height}"
    $('.resumeMain').transition(x: "#{width}", delay: 600).transition(y: pixelStr, complete: -> inceptionRouter.navigate("home/resume", trigger: true))
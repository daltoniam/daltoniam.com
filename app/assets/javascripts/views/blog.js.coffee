class Daltoniam.Views.BlogView extends Backbone.View
	template: HoganTemplates['blog']
	el: "#app"

	events: 
  	"click .blogMain" : "goHome"

	initialize: ->
		@collection = new Daltoniam.Collections.Posts()
		@listenTo @collection, 'add remove reset', @render, this
		@collection.fetch(reset: true)

	render: ->
		@$el.html @template.render()
		@addAll()


	addAll: ->
		@collection.forEach(@addOne,this)

	addOne: (item)->
		post = new Daltoniam.Views.PostView(model: item)
		$('.posts').append post.render()


	goHome: ->
		$('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
		$('.blogCircle').css("background": "#8e44ad")
		$('.postHeader').removeClass('fadeInRight').addClass('fadeOutRight')
		$('.posts').removeClass('bounceInUp').addClass('bounceOutDown')
		width = $('.blogMain').width() + 30
		height = $('.blogMain').height() - 20
		pixelStr = "#{height}"
		$('.blogMain').transition(x: "#{width}", delay: 600).transition(y: pixelStr, complete: -> inceptionRouter.navigate("home/blog", trigger: true))
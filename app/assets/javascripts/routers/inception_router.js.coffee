class Daltoniam.Routers.InceptionRouter extends Backbone.Router

  routes:
    ''                : 'getHome'
    'home(/:param)'   : 'getHome'
    'blog'            : 'getBlog'
    'blog/:param'     : 'getPost'
    'resume'          : 'getResume'

  getHome:(param) ->
    console.log("going home param: " + param)
    homeView = new Daltoniam.Views.HomeView({name: param})
    homeView.render()

  getBlog: ->
    blogView = new Daltoniam.Views.BlogView()

  getPost: (param) ->
    console.log("get blog post #{param}")
    blogView = new Daltoniam.Views.BlogPostView({id: param})

  getResume: ->
    resumeView = new Daltoniam.Views.ResumeView()
    resumeView.render()
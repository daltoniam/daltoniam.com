class Daltoniam.Routers.InceptionRouter extends Backbone.Router

  routes:
    ''                : 'getHome'
    'home(/:param)'   : 'getHome'
    'blog'            : 'getBlog'
    'blog/new'        : 'getBlogNew'
    'blog/:param'     : 'getPost'
    'blog/:param/edit': 'getBlogEdit'
    'resume'          : 'getResume'
    'about'           : 'getAbout'
    'project'         : 'getProject'
    'projects'        : 'getProject'

  getHome:(param) ->
    console.log("going home param: " + param)
    homeView = new Daltoniam.Views.HomeView({name: param})
    homeView.render()

  getBlog: ->
    blogView = new Daltoniam.Views.BlogView()

  getBlogNew: ->
    view = new Daltoniam.Views.NewPostView()
    view.render()

  getBlogEdit: (param) ->
    view = new Daltoniam.Views.NewPostView({id: param})

  getPost: (param) ->
    blogView = new Daltoniam.Views.BlogPostView({id: param})

  getResume: ->
    resumeView = new Daltoniam.Views.ResumeView()
    resumeView.render()
  
  getAbout: ->
    aboutView = new Daltoniam.Views.AboutView()
    aboutView.render()

  getProject: ->
    projectView = new Daltoniam.Views.ProjectView()
    projectView.render()
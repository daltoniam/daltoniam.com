class PostsController < ApplicationController
	def index
		@all = Post.paginate(:page => params[:page])
		for post in @all
			post.text = post.text.truncate(500)
		end
		expose @all
	end
	def show
		expose Post.find(params[:id])
	end
end

class PostsController < ApplicationController
	#index action
	def index
		@all = Post.paginate(:page => params[:page])
		expose @all, each_serializer: IndexPostSerializer
	end
	#show action
	def show
		expose Post.find(params[:id])
	end
	#create action
	def create
    @post = Post.new(post_params)
    @post.save!
    expose @post
  end
  #edit action
  def edit
    expose @post.find(params[:id])
  end
  #update action
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    expose @post
  end
  #destory action
  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    expose @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

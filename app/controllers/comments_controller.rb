class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  version 1

  def index
  	@post = Post.find(params[:post_id])
  	expose @post.comments
  end

  def show
  	@comment = Comment.find(params[:id])
  	expose @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(user: @current_user, text: params[:text])
    expose @comment
  end

  def destroy
    #@post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])#@post.comments.find(params[:id])
    @comment.destroy!
    expose @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

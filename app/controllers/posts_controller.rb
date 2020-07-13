class PostsController < ApplicationController
  def index
    posts = Post.all
    render json: posts
  end

  def create
    user = authorized_user
    if user.nil?
      render :head, status: :unauthorized and return
    end
    
    post = user.posts.build(post_params)
    if post.save
      render json: post, status: :created
    else
      render :head, status: :unprocessable_entity
    end 
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  private

  def post_params
    params.require(:post).permit(:title, :subtitle, :image, :body)
  end
end

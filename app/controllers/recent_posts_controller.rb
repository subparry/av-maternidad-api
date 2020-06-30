class RecentPostsController < ApplicationController
  def index
    recent = Post.order(:created_at).last(3)
    render json: recent
  end
end

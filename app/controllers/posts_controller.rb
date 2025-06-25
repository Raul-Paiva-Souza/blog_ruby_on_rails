class PostsController < ApplicationController
  before_action :set_post, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def my_posts
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id

    if @post.save!
      redirect_to my_posts_path, notice: "Post saved successfully!"
    else
      redirect_to new_posts_path, alert: "Post save error!"
    end
  end

  def edit
  end

  def update
    if @post.update!(posts_params)
      redirect_to my_posts_path, notice: "Post edited successfully!"
    else
      redirect_to my_posts_path, alert: "Post edit error!"
    end
  end

  def destroy
    @post.destroy
    if @post.destroy
      redirect_to my_posts_path, notice: "Post deleted successfully!"
    else
      redirect_to my_posts_path, alert: "Post delete error!"
    end
  end

  def posts_params
    params.require(:post).permit(:title, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

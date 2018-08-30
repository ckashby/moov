class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: 'Post successfully saved.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post successfully deleted."
  end

  def upvote
    @post.upvote_by current_user
    redirect_to post_path(@post), notice: 'Post successfully up voted.'
  end

  def downvote
    @post.downvote_by current_user
    redirect_to post_path(@post), notice: 'Post  successfully down voted'
  end

    private

    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :image, :user_id)
    end
end

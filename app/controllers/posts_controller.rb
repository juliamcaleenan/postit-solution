class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action only: [:edit, :update] do
    require_same_user_or_admin(@post.creator)
  end

  def index
    @posts = Post.all.sort_by{ |post| post.total_votes }.reverse
  end

  def show
    @comments = @post.comments.all
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Your post has been created'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post has been updated'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], voteable: @post, creator: current_user)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You can only vote once on a post"
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end

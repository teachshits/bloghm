class CommentsController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.ip = request.env['REMOTE_ADDR']
      if @comment.save
        respond_to do |format|
          format.js
        end
      else 
        redirect_to @post
      end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to post_path(@post), notice: 'Comment was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post), notice: 'Comment was successfully deleted'
  end
end

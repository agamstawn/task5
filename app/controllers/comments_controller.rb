class CommentsController < ApplicationController
  before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comments = Comment.new
  end

  def edit
    @comment = Comment.find_by_id(params[:id])
  end

  def create
    respond_to do |format|
      @comment = Comment.new(params_comment)
      if @comment.save
        format.js {@comments = Article.find_by_id(params[:comment][:article_id]).comments.order("id desc")}
      else
        format.js {@article = Article.find_by_id(params[:comment][:article_id])}
      end
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    respond_to do |format|
      flash[:notice] = "Success Delete a Records"
      redirect_to action: 'index'
      format.js
    end
  end

  private
  def params_comment
    params.require(:comment).permit(:article_id, :user_id, :content, :status)
  end

end

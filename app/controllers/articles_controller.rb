class ArticlesController < ApplicationController
  before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    # @articles = Article.search(params[:search]).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    @articles = Article.search(params[:search])
    @article = Article.new
    respond_to do|format|
      format.html
      # HardWorker.perform(@article.id)
      format.js {
        @Articles
        @article
      }
    end
  end

  def new
    @article = Article.new
    @article.comments.build
  end

  def edit

    @article = Article.find(params[:id])
    @article.comments.build

  end

  def create
    @article = Article.new(params_article)

    respond_to do |format|
      if @article.save
        # inline
        # FilterObscenity.new.perform(@article.id)
        # background
        # FilterObscenityJob.perform_later(@article.id)
        # native
        # HardWorker.perform_async(@article.id)
        HardWorker.perform_in(1.minute, @article.id)
        @articles= Article.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
        format.js

      else
        render 'new'
        format.js
      end
    end

  end
  def show
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.all
    @comment = Comment.new
    filename = "article.xlsx"
    respond_to do|format|
      format.html
      format.xlsx{}
    end
  end

  def update

    @article = Article.find_by_id(params[:id])

    if @article.update(params_article)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'

    end
  end

  def destroy
    @article = Article.find_by_id(params[:id])
    @article.destroy
    respond_to do |format|
      format.js{@articles}
    end
  end

  def import
    Article.import(params[:file])
    redirect_to root_url, notice: "Articles imported."
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  def params_article
    params.require(:article).permit(:title, :content, :status, comments_attributes: [ :id, :content , :_destroy])
  end


end

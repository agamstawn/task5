class ArticlesController < ApplicationController

  def index
    @articles = Article.search(params[:search]).paginate(:page => params[:page], :per_page => 10).includes(:comments)
    @article = Article.new
    respond_to do|format|
      format.html
      format.csv{ send_data @articles.to_csv}
      format.xls #{ send_data @articles.to_csv(col_sep:"\t")}
      format.js {
        @articles
        @article
      }
    end
  end

  def new
    @article = Article.new
    @article.comments.build
  end

  def edit
    @article.comments.build

  end

  def create
    @article = Article.new(params_article)

    respond_to do |format|
      if @article.save
        @articles= Article.paginate(:page => params[:page], :per_page => 10)
        format.js { @articles }

      else
        flash[:error] = "data not valid"
        render 'new'
        format.js
      end
    end

  end
  def show
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
  end

  def update

    @article = Article.find_by_id(params[:id])
    respond_to do |f|
      if @article.update(params_article)
        flash[:notice] = "Success Update Records"
        redirect_to action: 'index'
        f.js
      else
        flash[:error] = "data not valid"
        render 'edit'
        f.js
      end
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

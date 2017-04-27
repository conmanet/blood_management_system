require "slugify"

class Admin::ArticlesController < Admin::BaseController
  before_action :load_article, only: [:edit, :update, :destroy]

  def index
    @q = Article.newest.ransack params[:q]
    @articles = @q.result.page(params[:page]).per 10
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      flash[:success] = is_public? ? "Đã đăng bài lên trang chủ." : "Đã lưu vào nháp."
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @article.assign_attributes update_params
    @article.assign_attributes title_slug: make_slug
    if @article.save
      flash[:success] = is_public? ? "Thay đổi đã được lưu." : "Đã đóng bài viết."
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Đã xóa bài viết."
    else
      flash[:danger] = "Lỗi! không thể xóa bài viết lúc này."
    end
    redirect_to admin_articles_path
  end

  private
  def article_params
    params[:article].merge! is_public: is_public?, title_slug: make_slug, user_id: current_user.id
    params.require(:article).permit :title, :content, :image, :is_public, :title_slug, :user_id
  end

  def update_params
    params[:article].merge! is_public: is_public?
    params.require(:article).permit :title, :content, :image, :is_public, :title_slug, :user_id
  end

  def is_public?
    params[:commit] == "public"
  end

  def make_slug
    Slugify.create(params[:article][:title]) << "-" << SecureRandom.hex(3).upcase
  end

  def load_article
    render_404 unless (@article = Article.find_by id: params[:id])
  end
end

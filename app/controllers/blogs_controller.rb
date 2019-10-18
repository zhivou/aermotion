class BlogsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.order(id: :desc).page(params[:page]).per(7)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    local_params = blog_params
    local_params[:youtube_link] = pars_youtube_link(local_params[:youtube_link])
    @blog = Blog.new(local_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to admin_panel_path, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    blog_params[:youtube_link] = pars_youtube_link(blog_params[:youtube_link])
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(
        :title,
        :main_image,
        :body_area,
        :youtube_link)
  end

  def pars_youtube_link(link)
    return link.scan(/https:\/\/www.youtube.com\/watch\?v=(.{1,})/)[0][0] if link
    nil
  end
end

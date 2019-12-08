class FreeVideosController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_free_video, only: [:show, :edit, :update, :destroy]

  # GET /free_videos
  # GET /free_videos.json
  def index
    @free_videos = FreeVideo.all
  end

  # GET /free_videos/1
  # GET /free_videos/1.json
  def show
  end

  # GET /free_videos/new
  def new
    @free_video = FreeVideo.new
  end

  # GET /free_videos/1/edit
  def edit
  end

  # POST /free_videos
  # POST /free_videos.json
  def create
    video_params = free_video_params
    video_params[:url] = pars_youtube_link(video_params[:url])
    @free_video = FreeVideo.new(video_params)

    respond_to do |format|
      if @free_video.save
        format.html { redirect_to @free_video, notice: 'Free video was successfully created.' }
        format.json { render :show, status: :created, location: @free_video }
      else
        format.html { render :new }
        format.json { render json: @free_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /free_videos/1
  # PATCH/PUT /free_videos/1.json
  def update
    video_params = free_video_params
    video_params[:url] = pars_youtube_link(video_params[:url])
    respond_to do |format|
      if @free_video.update(video_params)
        format.html { redirect_to @free_video, notice: 'Free video was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_video }
      else
        format.html { render :edit }
        format.json { render json: @free_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_videos/1
  # DELETE /free_videos/1.json
  def destroy
    @free_video.destroy
    respond_to do |format|
      format.html { redirect_to free_videos_url, notice: 'Free video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_free_video
    @free_video = FreeVideo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def free_video_params
    params.require(:free_video).permit(:title, :url, :description)
  end

  def pars_youtube_link(link)
    return link.scan(/src="(.*?)"/)[0][0] unless link == ''
    nil
  end
end

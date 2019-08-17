class AdminPanelController < ApplicationController
  def index
    @users = User.all
  end

  def add_video
  end

  def add_user
  end
end

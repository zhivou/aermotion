class AdminPanelController < ApplicationController
  def index
    @users = User.all
  end
end

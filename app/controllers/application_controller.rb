class ApplicationController < ActionController::Base
  private
  def is_admin?
    redirect_to root_path unless current_user.admin
  end
end

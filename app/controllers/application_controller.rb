class ApplicationController < ActionController::Base
  include DefaultPageContent

  private
  def is_admin?
    unless user_signed_in?
      redirect_to root_path, notice: 'Only administrator can use this action.'
      return
    end

    unless current_user.admin
      redirect_to root_path, notice: 'Only administrator can use this action.'
    end
  end
end

class TutorialsController < ApplicationController
  def index
    if user_signed_in?
      @tutorials = WorkoutSet
                       .includes(:type)
                       .get_by_type('Tutorial').take.id
                       .exclude_current_user(current_user) rescue nil
    else
      @tutorials = WorkoutSet
                       .order("created_at desc")
                       .includes(:type)
                       .get_by_type('Tutorial').take.id rescue nil
    end
  end
end

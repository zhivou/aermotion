class AdminPanelController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?

  def index
  end

  def admin_show_users
    @users = User.order(:id).page(params[:page]).per(10)
  end

  def admin_workouts
    @workouts = WorkoutSet.order(:id).page(params[:page]).per(10)
  end

  def admin_users_mapping
    @users = User.order(:id).page(params[:page]).per(5)
  end

  def admin_user_connection
    @users = User.order(:id).page(params[:page]).per(10)
  end

  def admin_add_videos
    @videos = Medium.order(:id).page(params[:page]).per(10)
  end

  def admin_paypal_transactions
    @transactions = PayPalTransaction.order("id DESC").page(params[:page]).per(10)
  end

  def new_video
    @workouts = WorkoutSet.all
  end

  def admin_blogs
    @blogs = Blog.order(:id).page(params[:page]).per(10)
  end

  def create_video
    param_container = format_params
    message = "Link was successfully created."
    param_container.medium_id.each do |m|
      next if m == ""
      unless MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []
        message += "\nExcept Video: '#{Medium.find(m).title}' and Workout Set: '#{WorkoutSet.find(param_container.workout_id).title}' already linked."
        next
      end
      link = MediaWorkoutSet.new(medium_id: m, workout_set_id: param_container.workout_id)
      if link.save
      else
        flash[:notice] = "Not saved: #{link.errors}"
      end
    end
    redirect_to admin_panel_path, notice: message
  end

  def remove_video
    param_container = format_params
    message = "Link was successfully removed."
    param_container.medium_id.each do |m|
      next if m == ""
      if MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id) == []
        message += "\nExcept Video: '#{Medium.find(m).title}' and Workout Set: '#{WorkoutSet.find(param_container.workout_id).title}' already removed."
        next
      end
      link = MediaWorkoutSet.where(medium_id: m, workout_set_id: param_container.workout_id)
      link.delete_all
    end
    redirect_to admin_panel_path, notice: message
  end

  def create_user
    param_container = format_params_user

    message = "Link was successfully created."
    param_container.workout_id.each do |w|
      next if w == ""
      unless UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w) == []
        message += "\nExcept User: '#{User.find(param_container.user_id).email}' and Workout Set: '#{WorkoutSet.find(w).title}' already linked."
        next
      end
      link = UsersWorkoutSet.new(user_id: param_container.user_id, workout_set_id: w)
      if link.save
      else
        flash[:notice] = "Not saved: #{link.errors}"
      end
    end
    redirect_to admin_panel_path, notice: message
  end

  def remove_user
    param_container = format_params_user

    message = "Link was successfully removed."
    param_container.workout_id.each do |w|
      next if w == ""
      if UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w) == []
        message += "\nExcept User: '#{User.find(param_container.user_id).email}' and Workout Set: '#{WorkoutSet.find(w).title}' already removed."
        next
      end
      link = UsersWorkoutSet.where(user_id: param_container.user_id, workout_set_id: w)
      link.delete_all
    end
    redirect_to admin_panel_path, notice: message
  end

  def create_admin_user
    user = User.new(
        email: format_params_admin_user.email,
        password: format_params_admin_user.encrypted_password
    )
    if user.save
      redirect_to admin_user_connection_path, notice: "Admin user successfully created"
    else
      redirect_to admin_user_connection_path, notice: user.errors
    end
  end

  def seo_dynamic_data
    @site_config = SiteConfiguration.all
  end

  def seo_update_home
    success_flags = []
    error_flags = []
    settings = home_page_dynamic
    settings.each do |key, value|
      updating_key = SiteConfiguration.where(key: key).first
      unless updating_key.value == value
        if updating_key.update(value: value)
          success_flags << "Key #{key} was successfully updated and set to Value: #{value}"
        else
          error_flags << "Could not update Key #{key}. Possibly missing key in the configuration defaults check SiteConfiguration table"
        end
      end
    end

    respond_to do |format|
      if error_flags.length <= 0
        format.html { redirect_to seo_dynamic_data_path, notice: "#{ success_flags.length < 1 ? 'There was nothing to update!' : 'Settings updated successfully: ' + success_flags.join("\n") }" }
        format.json { render seo_dynamic_data_path, status: :created}
      else
        format.html { redirect_to seo_dynamic_data_path, notice: error_flags.inspect }
        format.json { render json: seo_dynamic_data_path.inspect , status: :unprocessable_entity }
      end
    end
  end

  private
  def link_set_params
    params.require(:link_sets).permit(
        :workout_link,
        :user_link,
        :admin_email,
        :admin_password,
        workout_link_list:[],
        video_link: [])
  end

  def format_params
    OpenStruct.new(
        medium_id: link_set_params[:video_link],
        workout_id: link_set_params[:workout_link]
    )
  end

  def format_params_user
    OpenStruct.new(
        user_id: link_set_params[:user_link],
        workout_id: link_set_params[:workout_link_list]
    )
  end

  def format_params_admin_user
    OpenStruct.new(
        email: link_set_params[:admin_email],
        encrypted_password: link_set_params[:admin_password]
    )
  end

  def is_admin?
    redirect_to root_path unless current_user.admin
  end

  def home_page_dynamic
    params.require(:home_page).permit(
        :home_page_title,
        :home_page_blue_part,
        :home_page_sub_title,
        :home_page_sub_title_two,
        :home_page_introduction_video_title,
        :home_page_introduction_video_sub_title,
        :home_page_introduction_video_url,
        :home_page_workouts_title,
        :home_page_workouts_sub_title,
        :home_page_tutorials_title,
        :home_page_tutorials_sub_title,
        :home_page_blogs_title,
        :home_page_blogs_sub_title,
        :home_page_contact_block,
        :home_page_html_title,
        :home_page_html_keys
    )
  end
end

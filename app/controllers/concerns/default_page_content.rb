module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  ##
  # Update Keywords if needed by adding it from tags in
  # forms
  #
  def set_page_defaults
    @site_defaults = SiteConfiguration.all
    @page_title ||= 'Aeromotion Pages'
    @seo_keywords ||= 'Aeromotion, Tutorials, Workouts, Best Trainings, Free Videos, Personal, Best'
  end
end

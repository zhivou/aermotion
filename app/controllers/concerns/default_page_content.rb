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
    puts ">>>>>>>>>>>>>>> RAN"
    @site_defaults = SiteConfiguration.all
  end
end

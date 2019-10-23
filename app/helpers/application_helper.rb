module ApplicationHelper
  def self.trim_url(url)
    return url.scan(/https:\/\/www.youtube.com\/watch\?v=(.{1,})/)[0][0] unless url == ''
    nil
  end
end

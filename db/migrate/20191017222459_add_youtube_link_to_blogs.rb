class AddYoutubeLinkToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :youtube_link, :string
  end
end

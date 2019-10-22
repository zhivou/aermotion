class CreateFreeVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :free_videos do |t|
      t.string :title
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end

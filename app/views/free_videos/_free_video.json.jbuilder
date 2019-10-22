json.extract! free_video, :id, :title, :url, :description, :created_at, :updated_at
json.url free_video_url(free_video, format: :json)

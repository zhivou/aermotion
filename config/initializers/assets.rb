# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( admin_panel.css )
Rails.application.config.assets.precompile += %w( admin_panel.js )
Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( my_videos.js )
Rails.application.config.assets.precompile += %w( my_videos.css )
Rails.application.config.assets.precompile += %w( blogs.css )
Rails.application.config.assets.precompile += %w( workout_sets.css )
Rails.application.config.assets.precompile += %w( hover_grid.css )
Rails.application.config.assets.precompile += %w( tutorial.css )
Rails.application.config.assets.precompile += %w( contact.css )
Rails.application.config.assets.precompile += %w( transaction.css )
Rails.application.config.assets.precompile += %w( media.css )
Rails.application.config.assets.precompile += %w( about.css )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'protectedplanet-frontend/dist/style')
Rails.application.config.assets.precompile += %w(html5shiv/dist/*)

Sprockets.register_preprocessor('text/css',
  AssetJoiner.new('stylesheets/custom.scss', 'protectedplanet-frontend/src/style/main')
)

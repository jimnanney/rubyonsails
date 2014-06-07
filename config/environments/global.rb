Rails.application.configure do
  config.i18n.enforce_available_locales = true
  config.assets.paths << Rails.root.join("app/assets/fonts")
  config.assets.paths << Rails.root.join("app/assets/images")
  config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.eot *.ttf *.woff *.svg)
  config.active_record.schema_format = :sql
  config.exceptions_app = self.routes
end

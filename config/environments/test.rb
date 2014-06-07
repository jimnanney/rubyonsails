Rails.application.configure do
  # config.action_view.raise_on_missing_translations = true
  config.action_controller.perform_caching = true
  config.action_dispatch.show_exceptions = false
  config.active_support.deprecation = :stderr
  config.cache_classes = true
  config.eager_load = true
  config.serve_static_assets = true
  config.consider_all_requests_local = true
  config.action_mailer.delivery_method = :test
  config.static_cache_control = "public, max-age=3600"
  config.action_controller.allow_forgery_protection = false
end

Rails.application.configure do
  config.action_controller.perform_caching = false
  config.consider_all_requests_local = true
  config.assets.raise_runtime_errors = true
  config.cache_classes = false
  config.force_ssl = false
  config.eager_load = false
  config.assets.debug = true
  config.serve_static_assets = true
  config.active_support.deprecation = :log
  config.action_mailer.perform_deliveries = true
  config.active_record.migration_error = :page_load
  config.action_mailer.raise_delivery_errors = true
end

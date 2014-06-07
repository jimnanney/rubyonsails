Rails.application.configure do
  config.static_cache_control = "public, max-age=3600"
  config.action_controller.perform_caching = true
  config.consider_all_requests_local = false
  config.log_tags = [ :subdomain, :uuid ]
  config.assets.css_compressor = :sass
  config.assets.version = "0.1"
  config.assets.compile = true
  config.cache_classes = true
  config.eager_load = true
  config.log_level = :info
  config.assets.digest = true
  config.autoflush_log = true
  config.i18n.fallbacks = true
  config.serve_static_assets = true
  config.exceptions_app = self.routes
  config.assets.js_compressor = :uglifier
  config.active_support.deprecation = :notify
  config.action_mailer.delivery_method = :smtp
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.raise_delivery_errors = true
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"
  config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.eot *.ttf *.woff *.svg)
end

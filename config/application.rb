require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
Bundler.require(:default, Rails.env)

module Blog
  class Application < Rails::Application
    require_relative "environments/global"
  end
end

module Rails
  def self.config
    application.config
  end

  # Don't get mad old Rails, please.
  if defined?(application.secrets)
    def self.secrets
      application.secrets
    end
  end

  # ---------------------------------------------------------------------------
  # Allows you to easily encrypt messages anywhere without much trouble using
  # keys from secrets file, this is useful for storing data that shouldn't
  # be tampered inside of forms.
  # ---------------------------------------------------------------------------

  if defined?(application.secrets)
    def self.encryptor
      @encryptor ||= begin
        salt = secrets.salt
        base = secrets.base
        ActiveSupport::MessageEncryptor.new(
          ActiveSupport::KeyGenerator.new(base).generate_key(salt))
      end
    end
  end
end

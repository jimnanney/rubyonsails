module ErrorConcerns
  extend ActiveSupport::Concern

  included do
    rescue_from FeatureNotEnabled, :with => :feature_not_enabled
    rescue_from UnauthorizedError, :with => :unauthorized_error
    rescue_from NotFoundError, :with => :not_found_error
    rescue_from ServerError, :with => :server_error
    rescue_from BadActivityError, :with => :bad_activity_error
  end

  def redirect_with_unauthorized(msg = nil)
    redirect_to :back, {
      :error => "You are not authorized to #{msg || "do that"}."
    }

    return false
  end

  def server_error
    render "errors/500", :status => 500
    return false
  end

  def feature_not_enabled
    redirect_to :root, {
      :error => "This feature is unavailable for you."
    }

    return false
  end

  def not_found_error
    render "errors/404", :status => 404
    return false
  end

  def unauthorized_error
    render "errors/401", :status => 401
    return false
  end

  def bad_activity_error
    reset_session
    redirect_to :root, {
      :error => "You have been logged out, bad activity detected."
    }

    return false
  end
end

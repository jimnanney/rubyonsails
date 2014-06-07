module ParamConcerns
  extend ActiveSupport::Concern

  included do |c|
    helper_method :safe_params
  end

  # -------------------------------------------------------------------
  # :utf8 is ignored because it's internal only.
  # :_method ignored because it's a METHOD indicator for PUT.
  # :authenticity_token is not used by us.
  # -------------------------------------------------------------------

  IGNORED_PARAMS = [
    :_method,
    :authenticity_token,
    :commit,
    :utf8
  ]

  private
  def _verify_valid_slug!
    if ! safe_params[:slug].try(:valid_uuid?)
      raise NotFoundError
    end
  end

  # -------------------------------------------------------------------
  # You'll need to set this up in your controller in order for it to
  # work properly (also see `self.allow_attr`):
  #
  #     allow_attr :action_name, :attr
  #     allow_attr :action_name, :nested_attr => [:attr1, :attr2]
  #
  # It is highly recommended you do one per line for code readability.
  # -------------------------------------------------------------------

  protected
  def safe_params
    allowed = self.class.ignored_params.
      values_at(action_name, controller_name).delete_if(&:nil?)

    ignored = self.class.ignored_params. \
      values_at(action_name, controller_name). \
        delete_if(&:nil?).push(*IGNORED_PARAMS)

    @_attrs ||= params.except(*ignored). \
      permit(*self.class.allowed_params[action_name])
  end

  module ClassMethods
    attr_reader :allowed_params
    attr_reader :ignored_params

    def inherited(cls)
      super

      [:allowed_params, :ignored_params].each do |k|
        cls.instance_variable_set("@#{k}", {})
      end
    end

    def allow_param(*params)
      opts = params.extract_options!
      whre = opts[:only] || \
        controller_name

      [whre].flatten.each do |k|
        (allowed_params[k.to_s] ||= []).push(*params)
      end
    end

    def ignore_param(*params)
      opts = params.extract_options!
      whre = opts[:only] || \
        controller_name

      (ignored_params[whre] ||= []).push(*params)
    end
  end
end

class ApplicationController < ActionController::Base
  include ErrorConcerns, AccountConcerns, ParamConcerns, TitleConcerns

  layout "app"
  protect_from_forgery :with => :exception
  add_flash_types :error, :success, :info, :warning

  def render(context = nil, opts = {}, &block)
    if context.is_a?(Hash)
      opts, context = context, nil
    end

    [:error, :success].each do |k|
      if opts[k] || opts[k.to_s]
        flash[k] = opts.delete(k) || opts.delete(k.to_s)
      end
    end

    super(
      context, opts, &block
    )
  end
end

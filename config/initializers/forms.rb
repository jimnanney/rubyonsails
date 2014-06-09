Rails.application.config.action_view.field_error_proc = Proc.new do |h, i|
  h.gsub(/class="/, %Q{class="error }).html_safe
end

SimpleForm.setup do |config|
  config.wrappers :default, {
    :hint_class => :field_with_hint,
    :error_class => :field_with_errors,
    :class => "input row",
  } \
  do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input

    [:hint, :error].each do |k|
      b.use k, :wrap_with => {
        :class => k,
        :tag => :span
      }
    end
  end

  config.boolean_style = :nested
  config.default_wrapper = :default
  config.label_class = "form-label col-5"
  config.input_class = "form-input col-7"
  config.error_notification_class = "error_notification"
  config.button_class = "btn"
  config.error_notification_tag = :div
  config.browser_validations = true
end

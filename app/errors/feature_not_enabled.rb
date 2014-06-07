class FeatureNotEnabled < StandardError
  def initialize
    super "This feature is not enabled at this time."
  end
end

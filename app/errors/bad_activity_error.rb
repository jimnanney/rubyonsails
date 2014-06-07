class BadActivityError < StandardError
  def initialize
    super "Bad Activity."
  end
end

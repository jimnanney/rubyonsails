class UnauthorizedError < StandardError
  def initialize
    super "Unauthorized."
  end
end

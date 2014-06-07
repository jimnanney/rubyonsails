class NotFoundError < StandardError
  def initialize
    super "Page not Found."
  end
end

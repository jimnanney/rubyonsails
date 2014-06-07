class ServerError < StandardError
  def initialize
    super "Server Problems."
  end
end

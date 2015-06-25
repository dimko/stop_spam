module StopSpam
  class Config
    attr_accessor :active, :expiration, :middleware_message, :namespace, :redis
  end
end

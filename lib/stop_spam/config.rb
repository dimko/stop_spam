module StopSpam
  class Config
    attr_accessor :active, :expiration, :middleware_message,
                  :minimum_confidence, :namespace, :redis
  end
end

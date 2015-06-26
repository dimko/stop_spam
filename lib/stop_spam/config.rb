module StopSpam
  class Config
    attr_accessor :active, :ban_message, :ban_time, :minimum_confidence,
                  :namespace, :redis, :whitelist
  end
end

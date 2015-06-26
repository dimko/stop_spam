require 'forwardable'
require "time"

require "httparty"
require "redis-namespace"

require "stop_spam/config"
require "stop_spam/ip"
require "stop_spam/version"

if defined?(::Rails)
  require "stop_spam/middleware"
  require "stop_spam/railtie"
end

module StopSpam
  extend self

  def process(id)
    return unless active? && !exclusion?(id)
    add(id) if IP.suspicious?(id)
  end

  def exclusion?(id)
    config.whitelist.include?(id)
  end

  def appears?(id)
    return if exclusion?(id)
    redis.exists(id)
  end

  def remove(id)
    redis.del(id)
  end

  def add(id)
    redis.setex id, config.ban_time, Time.now
    true
  end

  def keys
    k   = redis.keys
    k.zip redis.mget(*k)
  end

  def config
    @_config ||= Config.new
  end

  def configure
    config.instance_eval &Proc.new
  end

  def redis
    @_redis ||= Redis::Namespace.new config.namespace, redis: config.redis
  end

  def active?
    !!config.active
  end
end

StopSpam.configure do |config|
  config.active = true
  config.ban_message = "StopSpam: your IP address is banned"
  config.ban_time = 86400
  config.minimum_confidence = 5
  config.namespace = "stop:spam"
  config.whitelist = []
end

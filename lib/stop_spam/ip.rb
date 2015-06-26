module StopSpam
  class IP
    include HTTParty
    extend  Forwardable

    attr_reader :id

    base_uri 'http://us.stopforumspam.org'
    default_timeout 10
    format :json

    def_delegator :StopSpam, :config

    def initialize(id)
      @id = id
    end

    def self.suspicious?(id)
      new(id).suspicious?
    end

    def frequency
      response['frequency']
    end

    def confidence
      response['confidence']
    end

    def lastseen
      Time.parse response['lastseen'] if appears?
    end

    alias_method :last_seen, :lastseen

    def appears
      response['appears']
    end

    def suspicious?
      appears? && confidence >= config.minimum_confidence
    end

    def appears?
      appears == 1
    end

    protected

    def response
      @_response ||= perform_request
    end

    def perform_request
      json = self.class.get('/api', query: { ip: id, f: 'json' })
      json['ip']
    rescue StandardError
      {}
    end
  end
end

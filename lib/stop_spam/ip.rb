module StopSpam
  class IP
    include HTTParty

    attr_reader :id

    base_uri 'http://us.stopforumspam.org'
    default_timeout 10

    format :json

    def initialize(id)
      @id = id
    end

    def self.appears?(id)
      new(id).appears?
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

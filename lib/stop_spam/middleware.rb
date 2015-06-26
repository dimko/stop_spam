module StopSpam
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if StopSpam.active?
        request = Rack::Request.new(env)
        ip      = request.ip

        if StopSpam.appears?(ip)
          message = StopSpam.config.ban_message
          body    = message.respond_to?(:call) ? message.(request) : message

          [429, {}, [body]]
        else
          @app.call(env)
        end
      else
        @app.call(env)
      end
    end
  end
end

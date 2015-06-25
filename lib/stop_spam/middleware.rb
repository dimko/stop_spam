module StopSpam
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if StopSpam.active?
        request = Rack::Request.new(env)

        if StopSpam.appears?(request.ip)
          [ 429, {}, [StopSpam.config.middleware_message] ]
        else
          @app.call(env)
        end
      else
        @app.call(env)
      end
    end
  end
end

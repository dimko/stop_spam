module StopSpam
  class Railtie < Rails::Railtie
    initializer 'stop_spam.middleware' do |app|
      app.config.middleware.use StopSpam::Middleware
    end
  end
end

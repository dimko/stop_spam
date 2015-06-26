# StopSpam

Detect and ban spammers with stopforumspam.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stop_spam'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stop_spam

## Usage

It automatically integrates with Rails and renders the ban message for suspicious IP addresses.
But you need manually call `StopSpam.process(ip)` to perform an IP address check.

```ruby
unless @user = User.authenticate(params[:user])
  StopSpam.process(request.ip) # possible brute-force attack
end
```

## Configuration

Sample configuration:

```ruby
StopSpam.configure do |config|
  config.active = Rails.env.production?
  config.minimum_confidence = 1
  config.whitelist = [
    # ...
  ]
end
```

### Active

Enable or disable StopSpam.

```ruby
StopSpam.configure do |config|
  config.active = Rails.env.production?
end
```

### Ban time

Default is 86400 seconds (1 day).

```ruby
StopSpam.configure do |config|
  config.ban_time = 6.hours
end
```

### Ban message

Default is "StopSpam: your IP address is banned". Supports proc as well.

```ruby
StopSpam.configure do |config|
  config.ban_message = proc do |request|
    "IP #{request.ip} is banned"
  end
end
```

### Minimum confidence

Sets the minimum confidence is greater than IP will be banned.

```ruby
StopSpam.configure do |config|
  config.minimum_confidence = 1
end
```

### Namespace

Sets the redis namespace.

```ruby
StopSpam.configure do |config|
  config.namespace = "stop:spam"
end
```

### Whitelist

IP addresses that never will banned.

```ruby
StopSpam.configure do |config|
  config.whitelist = %w[
    192.168.1.1
    127.0.0.1
  ]
end
```

## Contributing

1. Fork it ( https://github.com/dimko/stop_spam/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

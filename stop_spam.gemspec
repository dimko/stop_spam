# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stop_spam/version'

Gem::Specification.new do |spec|
  spec.name          = "stop_spam"
  spec.version       = StopSpam::VERSION
  spec.authors       = ["Dmitriy Meremyanin"]
  spec.email         = ["deemox@gmail.com"]
  spec.summary       = %q{ Detect spammers with stopforumspam.com }
  spec.description   = %q{ Detect spammers with stopforumspam.com }
  spec.homepage      = "https://github.com/dimko/stop_spam"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.10"
  spec.add_dependency "redis-namespace"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake",    "~> 10.0"
end

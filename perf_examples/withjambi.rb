$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'jambi'
gem 'rack', '~> 1'
require 'rack'
puts Rack::VERSION.inspect
require 'webrat'

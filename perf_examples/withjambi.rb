$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'jambi'
begin
  gem 'doesntexist'
rescue Gem::LoadError
end
require 'ruby-debug'
# debugger
# x=1
gem 'rails', '= 2.2.2'
# gem 'rack', '~> 1'
# require 'rack'
# puts Rack::VERSION.inspect
# require 'webrat'

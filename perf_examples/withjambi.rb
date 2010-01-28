$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'jambi'
begin
  gem 'doesntexist'
rescue Gem::LoadError
end
require 'ruby-debug'
gem 'rails', '= 2.2.2'

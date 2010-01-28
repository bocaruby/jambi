$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'jambi'
begin
  gem 'doesntexist'
rescue Gem::LoadError
end
gem 'nokogiri'
require 'nokogiri'
puts "Memory usage: " + `ps u #{Process.pid}`.split("\n").last.split[5]


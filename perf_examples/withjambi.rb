$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'jambi'

gem 'rails', '~> 2'
# require 'activerecord'

# gem 'nokogiri', '~> 1'
# require 'nokogiri'
puts "Memory usage: " + `ps u #{Process.pid}`.split("\n").last.split[5]


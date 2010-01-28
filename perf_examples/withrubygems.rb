require 'rubygems'
begin
  gem 'doesntexist'
rescue Gem::LoadError
end
gem 'nokogiri'
require 'nokogiri'
puts "Memory usage: " + `ps u #{Process.pid}`.split("\n").last.split[5]

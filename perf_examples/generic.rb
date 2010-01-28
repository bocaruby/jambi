begin
  gem 'doesntexist'
rescue Gem::LoadError
end
require 'ruby-debug'
gem 'rails', '= 2.2.2'

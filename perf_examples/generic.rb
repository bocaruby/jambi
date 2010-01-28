begin
  gem 'doesntexist'
rescue Gem::LoadError
end
gem 'rails', '~> 2'

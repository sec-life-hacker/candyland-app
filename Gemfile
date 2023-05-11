# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# Web
gem 'puma'
gem 'rack-session', '~>2.0'
gem 'redis-rack', git: 'https://github.com/redis-store/redis-rack'
gem 'redis-store', git: 'https://github.com/PikachuEXE/redis-store', branch: 'fix/redis-client-compatibility'

gem 'roda'
gem 'slim'

# Configuration
gem 'figaro'
gem 'rake'

# Debugging
gem 'pry'

# Communication
gem 'http'

# Security
gem 'rack-ssl-enforcer'
gem 'rbnacl' # assumes libsodium package already installed

# Development
group :development do
  gem 'rubocop'
  gem 'rubocop-performance'
end

group :development, :test do
  gem 'rack-test'
  gem 'rerun'
end

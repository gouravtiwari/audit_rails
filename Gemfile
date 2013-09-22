source "http://rubygems.org"

# Declare your gem's dependencies in audit_rails.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem "spork", "~> 1.0rc"
  gem "guard-spork"
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-fsevent', '~> 0.9.1'
  gem "shoulda-matchers"
  gem 'coveralls', :require => false
  gem 'simplecov'
end

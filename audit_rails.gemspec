$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "audit_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "audit_rails"
  s.version     = AuditRails::VERSION
  s.authors     = ["Gourav Tiwari"]
  s.email       = ["gouravtiwari21@gmail.com"]
  s.homepage    = "https://github.com/gouravtiwari/audit_rails"
  s.summary     = "An action based auditor, which has internal as well as outgoing link tracking."
  s.description = "An action based auditor, which has internal as well as outgoing link tracking. Provides Analytics for User count in line-chart."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_runtime_dependency "to_xls", "~>1.5.1"
  s.add_runtime_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "spork", '~>1.0rc'
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "shoulda-matchers"
  # s.add_development_dependency "coveralls"
  s.add_development_dependency "simplecov"
end

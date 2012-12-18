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
  s.description = "It is inspired from many great audit gems in rails community that audits model and I was looking for a gem which can audit based on actions as well as can audit link tracking. This gem just serve this purpose."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~>2.12.0"
end

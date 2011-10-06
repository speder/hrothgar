$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hrothgar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hrothgar"
  s.version     = Hrothgar::VERSION
  s.authors     = ["Steve Pedersen"]
  s.email       = ["speder@pacbell.net"]
  s.homepage    = "https://github.com/speder/hrothgar"
  s.summary     = "NHPM Rails 3.1 engine demo."
  s.description = "NHPM Rails 3.1 engine demo."

# s.files      = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
# s.test_files = Dir["test/**/*"]
  s.files      = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
# s.executables
  s.require_paths = ['lib']

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rr"
end

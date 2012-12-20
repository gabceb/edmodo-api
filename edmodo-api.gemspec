# -*- encoding: utf-8 -*-
require File.expand_path('../lib/edmodo-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gabriel Cebrian"]
  gem.email         = ["gabceb@edcanvas.com"]
  gem.description   = %q{To use the Edmodo API for apps on the Edmodo ecosystem}
  gem.summary       = %q{Ruby wrapper for the Edmodo API}
  gem.homepage      = "http://github.com/gabceb/edmodo-api"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = "edmodo-api"
  gem.require_paths = ["lib"]
  gem.version       = Edmodo::API::VERSION

  gem.add_development_dependency 'rspec', '2.12.0'
  gem.add_development_dependency 'fakeweb', '1.3.0'
  gem.add_development_dependency 'awesome_print', '1.1.0'
  gem.add_development_dependency 'rake', '10.0.2'
end

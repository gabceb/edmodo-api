# -*- encoding: utf-8 -*-
require File.expand_path('../lib/edmodo-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gabriel Cebrian"]
  gem.email         = ["gabceb@edcanvas.com"]
  gem.description   = %q{To use the Edmodo API for apps on the Edmodo ecosystem}
  gem.summary       = %q{Ruby wrapper for the Edmodo API}
  gem.homepage      = "https://github.com/gabceb/edmodo-api"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = "edmodo-api"
  gem.require_paths = ["lib"]
  gem.version       = Edmodo::API::VERSION

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_dependency('httparty')
  gem.add_dependency('json')

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'rake'
end

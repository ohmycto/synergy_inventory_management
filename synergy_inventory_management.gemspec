# -*- encoding: utf-8 -*-
#$:.push File.expand_path("../lib", __FILE__)
#require "synergy_inventory_management/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "synergy_inventory_management"
  s.version     = '0.2'
  s.authors     = 'Sergey Chazov (Service & Consulting)'
  s.email       = 'service@secoint.ru'
  s.homepage    = "https://github.com/secoint/synergy_inventory_management"
  s.summary     = 'Manage inventory'
  s.description = 'Manage inventory'

  s.rubyforge_project = "synergy_inventory_management"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.8.7'
  s.add_dependency('spree_core', '>= 1.3.0')

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

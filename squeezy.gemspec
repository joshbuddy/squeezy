# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "squeezy/version"

Gem::Specification.new do |s|
  s.name        = "squeezy"
  s.version     = Squeezy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Hull"]
  s.email       = ["joshbuddy@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/squeezy"
  s.summary     = %q{Asset compression service via YUI compressor}
  s.description = %q{Asset compression service via YUI compressor}

  s.rubyforge_project = "squeezy"
  
  s.add_dependency "glassfish"
  s.add_dependency "sinatra"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

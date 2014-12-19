# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chosen/version"

Gem::Specification.new do |s|
  s.name        = "chosen"
  s.version     = Chosen::VERSION
  s.authors     = ["braham"]
  s.email       = ["brahamshakti@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Chosen a rails version of chosen jquery}
  s.description = %q{Chosen gem is a built on jQuery plugin that makes long, unwieldy select boxes much more user-friendly.}

  s.rubyforge_project = "chosen"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "app"]
end

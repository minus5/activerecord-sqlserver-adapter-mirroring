# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "activerecord-sqlserver-adapter-mirroring"
  s.version     = File.read('VERSION').strip
  s.authors     = ["ianic"]
  s.email       = ["ianic@minus5.hr"]
  s.homepage    = "https://github.com/minus5/activerecord-sqlserver-adapter-mirroring"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "activerecord-sqlserver-adapter-mirroring"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency "activerecord-sqlserver-adapter", "~> 3.2.3"
end

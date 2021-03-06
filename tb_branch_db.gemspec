# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tb_branch_db/version"

Gem::Specification.new do |s|
  s.name        = "tb_branch_db"
  s.version     = TbBranchDb::VERSION
  s.authors     = ["Thomas Baustert"]
  s.email       = ["business@thomasbaustert.de"]
  s.homepage    = ""
  s.summary     = %q{Rake tasks to branch a database}
  s.description = %q{Rake tasks to branch a database}

  s.rubyforge_project = "tb_branch_db"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

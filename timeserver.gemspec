# -*- encoding: utf-8 -*-
require File.expand_path('../lib/timeserver/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan LeCompte"]
  gem.email         = ["lecompte@gmail.com"]
  gem.description   = %q{Example time server that uses a pre-threading model (similar to pre-forking, but using threads instead of Kernel#fork.)}
  gem.summary       = %q{Example time server that uses a pre-threading model (similar to pre-forking, but using threads instead of Kernel#fork.)}
  gem.homepage      = "https://github.com/ryanlecompte/timeserver"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "timeserver"
  gem.require_paths = ["lib"]
  gem.version       = Timeserver::VERSION

  gem.add_development_dependency('rspec', '~> 2.9')
  gem.add_development_dependency('rake', '~> 0.9.2.2')
end

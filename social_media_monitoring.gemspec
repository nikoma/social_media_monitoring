# -*- encoding: utf-8 -*-
require File.expand_path('../lib/social_media_monitoring/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikolai Manek"]
  gem.email         = ["niko.manek@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "social_media_monitoring"
  gem.require_paths = ["lib"]
  gem.version       = SocialMediaMonitoring::VERSION
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "mash"
end

# -*- encoding: utf-8 -*-
require File.expand_path('../lib/social_media_monitoring/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikolai Manek"]
  gem.email         = ["niko.manek@gmail.com"]
  gem.description   = %q{Offers sentiment analysis,keyword tracking, geographic competitor search and reviews from several review sites}
  gem.summary       = %q{Keyword tracking, sentiment analysis, competitor search, reviews}
  gem.homepage      = "https://github.com/nikoma/social_media_monitoring"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "social_media_monitoring"
  gem.require_paths = ["lib"]
  gem.version       = SocialMediaMonitoring::VERSION
  
  gem.add_runtime_dependency "httparty"
  gem.add_runtime_dependency "mash"
end

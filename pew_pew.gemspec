require './lib/pew_pew/version'

Gem::Specification.new do |gem|
  gem.name = 'pew_pew'
  gem.version = PewPew::VERSION
  gem.summary = 'A Ruby library for using the Mailgun API.'
  gem.homepage = 'http://github.com/tylerhunt/pew_pew'
  gem.author = 'Tyler Hunt'

  gem.add_dependency 'faraday_middleware', '~> 0.8.0'
  gem.add_dependency 'hashie', '~> 1.1'
  gem.add_dependency 'relax', '~> 0.2.0'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'vcr', '~> 2.2'

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end

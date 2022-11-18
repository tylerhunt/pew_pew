require './lib/pew_pew/version'

Gem::Specification.new do |gem|
  gem.name = 'pew_pew'
  gem.version = PewPew::VERSION
  gem.summary = 'A Ruby client library for using the Mailgun web service.'
  gem.homepage = 'http://github.com/tylerhunt/pew_pew'
  gem.author = 'Tyler Hunt'

  gem.required_ruby_version = '>= 2.6'

  gem.add_dependency 'faraday-mashify'
  gem.add_dependency 'faraday-multipart'
  gem.add_dependency 'hashie', '~> 1.1'
  gem.add_dependency 'relax', '~> 0.3.0'
  gem.add_development_dependency 'rspec', '~> 3.12'
  gem.add_development_dependency 'rspec-its', '~> 1.3'
  gem.add_development_dependency 'vcr', '~> 6.1'

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end

require './lib/pew_pew/version'

Gem::Specification.new do |spec|
  spec.name = 'pew_pew'
  spec.version = PewPew::VERSION
  spec.authors = ['Tyler Hunt']
  spec.summary = 'A Ruby client library for using the Mailgun web service.'
  spec.homepage = 'http://github.com/tylerhunt/pew_pew'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'faraday-mashify'
  spec.add_dependency 'faraday-multipart'
  spec.add_dependency 'hashie', '~> 1.1'
  spec.add_dependency 'relax', '~> 0.3.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rspec-its', '~> 1.3'
  spec.add_development_dependency 'vcr', '~> 6.1'

  spec.files = `git ls-files`.split($\)
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end

# frozen_string_literal: true

require_relative 'lib/pew_pew/version'

Gem::Specification.new do |spec|
  spec.name = 'pew_pew'
  spec.version = PewPew::VERSION
  spec.authors = ['Tyler Hunt']
  spec.email = ['tyler@tylerhunt.com']

  spec.summary = 'A Ruby client for the Mailgun API.'
  spec.homepage = 'http://github.com/tylerhunt/pew_pew'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    pattern = %r{
      \A
      (?:
        (?:bin|test|spec|features)/
        |
        \.(?:git|travis|circleci)
        |
        appveyor
      )
    }x

    `git ls-files -z`
      .split('\x0')
      .reject { |file| file == __FILE__ || file.match(pattern) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |file| File.basename(file) }
  spec.require_paths = ['lib']

  spec.add_dependency 'addressable', '~> 2.0'
  spec.add_dependency 'dry-monads'
  spec.add_dependency 'dry-validation'
  spec.add_dependency 'multipart-post', '~> 2.2'
  spec.add_development_dependency 'mail', '~> 2.7'
  spec.add_development_dependency 'net-smtp', '~> 0.3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.15'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.18'
  spec.add_development_dependency 'yard', '~> 0.9'
end

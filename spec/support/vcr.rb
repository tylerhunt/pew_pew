# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('<MAILGUN_DOMAIN>') {
    ENV.fetch('MAILGUN_DOMAIN')
  }
  config.filter_sensitive_data('<BASIC_AUTH>') {
    require 'base64'
    credentials = "#{PewPew::API::USERNAME}:#{ENV.fetch('MAILGUN_API_KEY')}"
    Base64.encode64(credentials).chomp
  }

  config.cassette_library_dir = File.expand_path('../fixtures', __dir__)
end

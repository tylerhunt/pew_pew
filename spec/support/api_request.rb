# frozen_string_literal: true

RSpec.shared_context 'API request', :api_request do
  let(:api_key) { ENV.fetch('MAILGUN_API_KEY') }
  let(:domain) { ENV.fetch('MAILGUN_DOMAIN') }

  let(:api) { PewPew::API.new(api_key: api_key) }
end

require 'json'
require 'support/api_request'
require 'support/vcr'

module PewPew
  RSpec.describe Routes, :api_request do
    subject(:routes) { described_class.new(api: api) }

    let(:address) { "test@#{ENV.fetch('MAILGUN_DOMAIN')}" }
    let(:expression) { "match_recipient('#{address}')" }

    describe '#create', vcr: { cassette_name: 'routes/create' } do
      let(:created) { [] }

      after do
        created.each { |route| routes.remove(id: route.fetch(:id)).value! }
      end

      it 'creates a route with the given expression' do
        route = parse_route(routes.create(expression: expression).value!)

        expect(route.fetch(:id)).to match /[\da-f]{24}/

        created << route
      end
    end

    describe '#remove', vcr: { cassette_name: 'routes/remove' } do
      let!(:route) {
        parse_route(routes.create(expression: expression).value!)
      }

      it 'removes the route with the given ID' do
        response = routes.remove(id: route.fetch(:id)).value!

        expect(response.code).to eq '200'
      end
    end

    def parse_route(response)
      JSON.parse(response.body, symbolize_names: true).fetch(:route)
    end
  end
end

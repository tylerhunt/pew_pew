module PewPew
  RSpec.describe Resource do
    let(:client) { Client.new }

    subject(:resource) { Class.new { include Resource }.new(client) }

    context '#connection' do
      let(:connection) { resource.send(:connection) }

      context 'middleware' do
        let(:handlers) { connection.builder.handlers }

        [
          Resource::ResponseDecorator,
          Faraday::Mashify::Middleware,
          Faraday::Response::Json,
          Faraday::Multipart::Middleware,
          Faraday::Request::UrlEncoded
        ].each.with_index do |middleware, index|
          it "uses #{middleware}" do
            expect(handlers.index(middleware)).to eq index
          end
        end
      end
    end
  end

  RSpec.describe Resource::ResponseDecorator do
    subject(:middleware) { described_class.new }

    it { is_expected.to be_a Faraday::Middleware }

    it 'converts an array response into a mash' do
      env = { body: [:response] }

      middleware.on_complete env

      expect(env).to match a_hash_including(
        body: an_object_having_attributes(total_count: 1, items: [:response])
      )
    end

    it 'stores the request status on the response body' do
      env = { body: Response.new, status: 200 }

      expect { middleware.on_complete env }
        .to change(env[:body], :status)
        .from(nil)
        .to(200)
    end
  end
end

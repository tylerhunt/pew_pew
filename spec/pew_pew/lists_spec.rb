require 'support/api_request'
require 'support/vcr'

module PewPew
  RSpec.describe Lists, :api_request do
    let(:lists) { described_class.new(api: api) }

    describe '#create', vcr: { cassette_name: 'lists/create' } do
      let(:address) { "test@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      after do
        lists.remove(address: address).value!
      end

      it 'creates a mailing list with the given address' do
        lists.create(address: address).value!
      end
    end

    describe '#remove', vcr: { cassette_name: 'lists/remove' } do
      let(:address) { "test@#{ENV.fetch('MAILGUN_DOMAIN')}" }

      before do
        lists.create(address: address).value!
      end

      it 'removes mailing list with the given address' do
        lists.remove(address: address).value!
      end
    end
  end
end

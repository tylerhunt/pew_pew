require 'mail'

require 'support/api_request'
require 'support/vcr'

module PewPew
  RSpec.describe Messages, :api_request do
    let(:messages) { described_class.new(api: api) }

    describe '#send', vcr: { cassette_name: 'messages/send' } do
      let(:address) { "test@#{domain}" }
      let(:text) { 'Text body.' }

      it 'sends a message' do
        messages
          .send(domain: domain, to: address, from: address, text: text)
          .value!
      end
    end

    describe '#send_mime', vcr: { cassette_name: 'messages/send_mime' } do
      let(:address) { "test@#{domain}" }
      let(:message) { Mail.new.to_s }

      it 'sends a message' do
        messages
          .send_mime(domain: domain, to: address, message: message)
          .value!
      end
    end
  end
end

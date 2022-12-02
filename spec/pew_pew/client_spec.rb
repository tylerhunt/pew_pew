require 'pew_pew/client'

module PewPew
  RSpec.describe Client do
    subject(:client) { described_class.new }

    describe '#lists' do
      it 'returns a lists resource' do
        expect(client.lists).to be_a Lists
      end
    end

    describe '#messages' do
      it 'returns a messages resource' do
        expect(client.messages).to be_a Messages
      end
    end

    describe '#routes' do
      it 'returns a routes resource' do
        expect(client.routes).to be_a Routes
      end
    end
  end
end

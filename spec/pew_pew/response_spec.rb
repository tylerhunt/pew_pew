module PewPew
  RSpec.describe Response do
    it { should be_a Hashie::Mash }

    context '#count' do
      subject(:response) { described_class.new(count: 2) }

      it 'returns the value of the count attribute' do
        expect(response.count).to eq 2
      end
    end

    context '#success?' do
      subject(:response) { described_class.new(status: status) }

      context 'when the status is 200' do
        let(:status) { 200 }

        it 'returns true' do
          expect(response).to be_success
        end
      end

      context 'when the status is 400' do
        let(:status) { 400 }

        it 'returns false' do
          expect(response).to_not be_success
        end
      end
    end
  end
end

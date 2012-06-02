require 'spec_helper'

describe PewPew::Response do
  it { should be_a(Hashie::Mash) }

  context '#count' do
    it 'returns the value of the count attribute' do
      described_class.new(count: 2).count.should == 2
    end
  end

  context '#success?' do
    it 'returns true if the status is 200' do
      described_class.new(status: 200).should be_success
    end

    it 'returns false if the status is 400' do
      described_class.new(status: 400).should_not be_success
    end
  end
end

require 'spec_helper'

describe PewPew::Resources::Stats, :resource do
  context '#for_domain' do
    let(:response) { described_class.new(client).find(1) }

    subject { client.stats }

    specify { should be_success }

    its(:body) { should match(/{\s+"total_count": 0,\s+"items": \[\]\s+}/) }
  end
end

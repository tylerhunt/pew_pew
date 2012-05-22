require 'spec_helper'

describe PewPew::Resources::Stats, :resource do
  let(:resource) { described_class.new(client) }

  context '#all' do
    subject { resource.all }

    specify { should be_success }

    its(:body) { should match(/{\s+"total_count": 0,\s+"items": \[\]\s+}/) }
  end
end

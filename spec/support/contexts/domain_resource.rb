RSpec.shared_context 'domain resource', :domain do
  context 'options' do
    subject { described_class.new(client, options) }

    context 'without options' do
      let(:options) { {} }

      its(:domain) { should == client.config.domain }
    end

    context 'with option :domain' do
      let(:options) { { domain: 'pewpew.test' } }

      its(:domain) { should == 'pewpew.test'}
    end
  end
end

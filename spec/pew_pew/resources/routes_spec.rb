require 'spec_helper'

describe PewPew::Resources::Routes, :resource do
  let(:options) { {} }
  let(:resource) { described_class.new(client, options) }

  context '#all' do
    let(:response) { resource.all }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:total_count) { should == 0 }
    its(:items) { should == [] }
  end

  context '#find' do
    let(:response) { resource.find('4fc850083533542f7704bc05') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }

    context 'route' do
      subject { response.route }

      its(:id) { should == '4fc850083533542f7704bc05' }
      its(:priority) { should == 1 }
      its(:description) { should == 'Forward Gmail' }
      its(:expression) { should == "match_recipient('.*@gmail.com')" }
      its(:actions) { should == ["forward('gmail@example.com')"] }
      its(:created_at) { should == 'Fri, 01 Jun 2012 05:15:52 GMT' }
    end
  end

  context '#create' do
    let(:params) do
      {
        priority: 1,
        description: 'Forward Gmail',
        expression: "match_recipient('.*@gmail.com')",
        action: "forward('gmail@example.com')"
      }
    end

    let(:response) { resource.create(params) }

    subject { response }

    context 'with a single action' do
      specify { should be_success }

      its(:status) { should == 200 }
      its(:message) { should == 'Route has been created' }

      context 'route' do
        subject { response.route }

        its(:id) { should == '4fc850083533542f7704bc05' }
        its(:priority) { should == params[:priority] }
        its(:description) { should == params[:description] }
        its(:expression) { should == params[:expression] }
        its(:actions) { should == [params[:action]] }
        its(:created_at) { should == 'Fri, 01 Jun 2012 05:15:52 GMT' }
      end
    end

    context 'with multiple actions' do
      before do
        params.merge!(action: [params[:action], 'stop()'])
      end

      specify { should be_success }

      its(:status) { should == 200 }
      its(:message) { should == 'Route has been created' }

      context 'route' do
        subject { response.route }

        its(:id) { should == '4fc854bd9d12a36fc504d4b3' }
        its(:priority) { should == params[:priority] }
        its(:description) { should == params[:description] }
        its(:expression) { should == params[:expression] }
        its(:actions) { should == params[:action] }
        its(:created_at) { should == 'Fri, 01 Jun 2012 05:35:57 GMT' }
      end
    end
  end

  context '#update' do
    let(:params) { { priority: 2 } }
    let(:response) { resource.update('4fc850083533542f7704bc05', params) }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Route has been updated' }

    its(:id) { should == '4fc850083533542f7704bc05' }
    its(:priority) { should == params[:priority] }
    its(:description) { should == 'Forward Gmail' }
    its(:expression) { should == "match_recipient('.*@gmail.com')" }
    its(:actions) { should == ["forward('gmail@example.com')"] }
    its(:created_at) { should == 'Fri, 01 Jun 2012 05:15:52 GMT' }
  end

  context '#remove' do
    let(:response) { resource.remove('4fc854bd9d12a36fc504d4b3') }

    subject { response }

    specify { should be_success }

    its(:status) { should == 200 }
    its(:message) { should == 'Route has been deleted' }

    its(:id) { should == '4fc854bd9d12a36fc504d4b3' }
  end
end

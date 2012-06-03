require 'spec_helper'

describe PewPew::Resource do
  let(:client) { PewPew::Client.new }
  let(:resource) { Class.new { include PewPew::Resource }.new(client) }

  context '#connection' do
    subject { resource.send(:connection) }

    context 'middleware' do
      let(:handlers) { subject.builder.handlers }

      [
        PewPew::Resource::ResponseDecorator,
        FaradayMiddleware::Mashify,
        FaradayMiddleware::ParseJson,
        Faraday::Request::Multipart,
        Faraday::Request::UrlEncoded,
        Faraday::Adapter::NetHttp
      ].each.with_index do |middleware, index|
        it "uses #{middleware}" do
          handlers.index(middleware).should == index
        end
      end
    end
  end
end

describe PewPew::Resource::ResponseDecorator do
  it { should be_a(Faraday::Response::Middleware) }

  it 'converts an array response into a mash' do
    env = { body: [:response] }
    subject.on_complete(env)
    env[:body].total_count.should == 1
    env[:body].items.should == [:response]
  end

  it 'stores the request status on the response body' do
    env = { body: PewPew::Response.new, status: 200 }

    expect {
      subject.on_complete(env)
    }.to change(env[:body], :status).from(nil).to(200)
  end
end

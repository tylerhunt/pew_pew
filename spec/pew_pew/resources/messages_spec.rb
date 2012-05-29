require 'spec_helper'

describe PewPew::Resources::Messages, :resource do
  let(:options) { {} }
  let(:resource) { described_class.new(client, options) }

  context 'options' do
    subject { resource }

    context 'without options' do
      its(:domain) { should == client.config.domain }
    end

    context 'with option :domain' do
      let(:options) { { domain: 'pewpew.test' } }

      its(:domain) { should == 'pewpew.test'}
    end
  end

  context '#send_email' do
    let(:params) {
      {
        to: 'pewpew@devoh.com',
        from: 'pewpew@devoh.com',
        subject: 'Test',
        text: 'This is a test message.'
      }
    }

    let(:file) { Faraday::UploadIO.new('spec/fixtures/image.png', 'image/png') }
    let(:response) { resource.send_email(params) }

    subject { response }

    context 'minimal case' do
      specify { should be_success }
    end

    context 'with attachments' do
      before do
        params.merge!(attachment: file)
      end

      specify { should be_success }
    end

    context 'with inline attachments' do
      before do
        params.merge!(
          html: "#{params[:text]} <img src=\"cid:image.png\">",
          inline: file
        )
      end

      specify { should be_success }
    end
  end
end

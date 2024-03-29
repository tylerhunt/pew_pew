module PewPew
  module Resources
    RSpec.describe Messages, :resource, :domain do
      let(:resource) { described_class.new(client) }

      context '#send_email' do
        let(:params) {
          {
            to: 'pewpew@devoh.com',
            from: 'pewpew@devoh.com',
            subject: 'Test',
            text: 'This is a test message.'
          }
        }

        let(:file) {
          Faraday::UploadIO.new('spec/fixtures/image.png', 'image/png')
        }

        subject { resource.send_email(params) }

        specify { should be_success }

        context 'with an attachment' do
          before do
            params.merge!(attachment: file)
          end

          specify { should be_success }
        end

        context 'with an inline attachment' do
          before do
            params.merge!(
              html: "#{params[:text]} <img src=\"cid:image.png\">",
              inline: file
            )
          end

          specify { should be_success }
        end
      end

      context '#send_mime' do
        let(:message) do
          Faraday::UploadIO.new('spec/fixtures/mime.eml', 'message/rfc822')
        end

        let(:params) { { to: 'pewpew@devoh.com', message: message } }

        subject { resource.send_mime(params) }

        specify { should be_success }
      end
    end
  end
end

module PewPew
  module Resources
    class Messages
      include Resource
      include Domain

      # Sends an email.
      #
      # @option params [String] :from email address to use for the `From` header
      # @option params [String, Array<String>] :to recipient or list of
      #   recipient email addresses
      # @option params [String] :cc same as `:to`, but for CC
      # @option params [String] :bcc same as `:to`, but for BCC
      # @option params [String] :subject message subject
      # @option params [String] :text text version of the message body
      # @option params [String] :html HTML version of the message body
      # @option params [File, Array<File>] :attachment file attachments
      # @option params [File, Array<File>] :inline inline file attachments
      # @return [Mash] the response body
      def send_email(params)
        post("#{domain}/messages", params)
      end
    end
  end
end

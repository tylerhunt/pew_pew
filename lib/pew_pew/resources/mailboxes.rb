module PewPew
  module Resources
    class Mailboxes
      include Resource
      include Domain

      # Fetches all defined mailboxes.
      #
      # @return [Mash] the response body
      def all
        get("#{domain}/mailboxes")
      end

      # Creates a new mailbox.
      #
      # @option params [String] :mailbox the name of the mailbox
      # @option params [String] :password the mailbox password
      # @return [Mash] the response body
      def create(params)
        post("#{domain}/mailboxes", params)
      end

      # Updates an existing mailbox by mailbox name.
      #
      # @param mailbox [String] the name of the mailbox to be updated
      # @option params [String] :password the mailbox password
      # @return [Mash] the response body
      def update(mailbox, params)
        put("#{domain}/mailboxes/#{mailbox}", params)
      end

      # Removes an existing mailbox by mailbox name.
      #
      # @param mailbox [String] the name of the mailbox to be deleted
      # @return [Mash] the response body
      def remove(mailbox)
        delete("#{domain}/mailboxes/#{mailbox}")
      end
    end
  end
end

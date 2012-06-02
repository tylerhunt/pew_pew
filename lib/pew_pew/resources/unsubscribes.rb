module PewPew
  module Resources
    class Unsubscribes
      include Resource
      include Domain

      # Fetches all unsubscribe events.
      #
      # @return [Mash] the response body
      def all
        get("#{domain}/unsubscribes")
      end

      # Fetch all unsubscribe events by address.
      #
      # @param address [String] the address to fetch unsubscribe events for
      # @return [Mash] the response body
      def find(address)
        get("#{domain}/unsubscribes/#{address}")
      end

      # Creates a new unsubscribe event.
      #
      # @option params [String] :address the email address to unsubscribe
      # @option params [String] :tag optional tag to unsubscribe from (defaults
      #   to unsubscribing the address completely from the domain)
      # @return [Mash] the response body
      def create(params)
        params[:tag] ||= '*'
        post("#{domain}/unsubscribes", params)
      end

      # Removes existing unsubscribe events.
      #
      # @param address_or_id [String] the address to remove all the unsubscribe
      #   events for, or a single unsubscribe event ID to remove
      # @return [Mash] the response body
      def remove(address_or_id)
        delete("#{domain}/unsubscribes/#{address_or_id}")
      end
    end
  end
end

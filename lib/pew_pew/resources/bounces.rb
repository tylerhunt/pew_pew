module PewPew
  module Resources
    class Bounces
      include Resource
      include Domain

      # Fetches all bounces.
      #
      # @return [Mash] the response body
      def all
        get("#{domain}/bounces")
      end

      # Fetch all bounces by address.
      #
      # @param address [String] the address to fetch bounces for
      # @return [Mash] the response body
      def find(address)
        get("#{domain}/bounces/#{address}")
      end

      # Creates a new bounce.
      #
      # @option params [String] :address the email address to add
      # @option params [String] :code error code (defaults to 550)
      # @option params [String] :error error description (defaults to blank)
      # @return [Mash] the response body
      def create(params)
        post("#{domain}/bounces", params)
      end

      # Removes existing bounces.
      #
      # @param address_or_id [String] the address to remove all the bounces for
      # @return [Mash] the response body
      def remove(address_or_id)
        delete("#{domain}/bounces/#{address_or_id}")
      end
    end
  end
end

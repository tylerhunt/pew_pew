module PewPew
  module Resources
    class Complaints
      include Resource
      include Domain

      # Fetches all spam complaints.
      #
      # @return [Mash] the response body
      def all
        get("#{domain}/complaints")
      end

      # Fetch all spam complaints by address.
      #
      # @param address [String] the address to fetch spam complaints for
      # @return [Mash] the response body
      def find(address)
        get("#{domain}/complaints/#{address}")
      end

      # Creates a new spam complaint.
      #
      # @option params [String] :address the email address to add
      # @return [Mash] the response body
      def create(params)
        post("#{domain}/complaints", params)
      end

      # Removes existing spam complaints.
      #
      # @param address_or_id [String] the address to remove all the spam
      #   complaints for
      # @return [Mash] the response body
      def remove(address_or_id)
        delete("#{domain}/complaints/#{address_or_id}")
      end
    end
  end
end

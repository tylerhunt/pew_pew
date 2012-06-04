require 'json'

module PewPew
  module Resources
    class Lists
      include Resource

      # Fetches all defined mailing lists.
      #
      # @return [Mash] the response body
      def all
        get('lists')
      end

      # Fetch a mailing list by email address.
      #
      # @param address [String] the email address of the mailing list to fetch
      # @return [Mash] the response body
      def find(address)
        get("lists/#{address}")
      end

      # Creates a new mailing list.
      #
      # @option params [String] :description optional list description
      # @option params [String] :name optional mailing list name
      # @option params [String] :address email address for the mailing list
      # @return [Mash] the response body
      def create(params)
        post('lists', params)
      end

      # Updates an existing mailing list by email address.
      #
      # @param address [String] the email address of the mailing list to update
      # @option params [String] :description optional list description
      # @option params [String] :name optional mailing list name
      # @option params [String] :address email address for the mailing list
      # @return [Mash] the response body
      def update(address, params)
        put("lists/#{address}", params)
      end

      # Removes an existing mailing list by email address.
      #
      # @param address [String] the email address of the mailing list to remove
      # @return [Mash] the response body
      def remove(address)
        delete("lists/#{address}")
      end

      # Fetches a summary of the results for a given mailing list, like numbers
      # of clicks, opens, etc. Includes unique numbers (e.g. number of unique
      # recipients who clicked) as well.
      #
      # @param address [String] the email address of the mailing list to fetch
      # @return [Mash] the response body
      def stats(address)
        get("lists/#{address}/stats")
      end

      # Fetches all defined mailing list members.
      #
      # @param address [String] the email address of the mailing list
      # @return [Mash] the response body
      def all_members(address)
        get("lists/#{address}/members")
      end

      # Fetch a mailing list member by email address.
      #
      # @param address [String] the email address of the mailing list
      # @param member_address [String] the email address of the member to fetch
      # @return [Mash] the response body
      def find_member(address, member_address)
        get("lists/#{address}/members/#{member_address}")
      end

      # Adds a new member to a mailing list.
      #
      # @param address [String] the email address of the mailing list
      # @option params [String] :address the email address of the member
      # @option params [String] :name optional member name
      # @option params [Hash] :vars optional dictionary of arbitrary member
      #   parameters (will be encoded as JSON)
      # @option params [Boolean] :subscribed if false, add the member as
      #   unsubscribed
      # @option params [Boolean] :upsert if true, update an existing member
      #   instead of returning an error
      # @return [Mash] the response body
      def create_member(address, params)
        params[:vars] = params[:vars].to_json
        post("lists/#{address}/members", params)
      end

      # Updates an existing mailing list member by email address.
      #
      # @param address [String] the email address of the mailing list
      # @param member_address [String] the email address of the member to update
      # @option params [String] :address the email address of the member
      # @option params [String] :name optional member name
      # @option params [Hash] :vars optional dictionary of arbitrary member
      #   parameters (will be encoded as JSON)
      # @option params [Boolean] :subscribed if false, add the member as
      #   unsubscribed
      # @return [Mash] the response body
      def update_member(address, member_address, params)
        put("lists/#{address}/members/#{member_address}", params)
      end

      # Removes an existing mailing list member by email address.
      #
      # @param address [String] the email address of the mailing list
      # @param member_address [String] the email address of the member to remove
      # @return [Mash] the response body
      def remove_member(address, member_address)
        delete("lists/#{address}/members/#{member_address}")
      end
    end
  end
end

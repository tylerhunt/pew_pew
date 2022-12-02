# action frozen_string_literal: true

require_relative 'lists/create'
require_relative 'lists/create_member'
require_relative 'lists/remove'
require_relative 'lists/remove_member'
require_relative 'lists/update_member'

module PewPew
  # Provide access to the mailing lists resource.
  #
  # See https://documentation.mailgun.com/en/latest/api-mailinglists.html.
  class Lists
    def initialize(api:)
      self.api = api
    end

    # Creates a new mailing list.
    #
    # @example
    #   client.lists.create(address: 'list@example.com')
    #
    # @param address [String] Mailing list address
    # @param name [String] Mailing list name
    # @param description [String] Mailing list description
    # @param access_level [String] `list` (default) or `sender`
    # @param reply_preference [String]
    def create(**data)
      Create.new(api: api).call(**data)
    end

    # Removes a mailing list.
    #
    # @example
    #   client.lists.remove(address: 'list@example.com')
    #
    # @param address [String]
    def remove(address:)
      Remove.new(api: api).call(address: address)
    end

    # Adds a member to the mailing list.
    #
    # @example
    #   client.lists.create_member(
    #     'list@example.com',
    #     address: 'member@example.com',
    #   )
    #
    # @param list_address [String] Mailing list address
    # @param address [String] Member address
    # @param name [String] Mailing list name
    # @param vars [String] Additional JSON-encoded parameters
    # @param subscribed [String] `yes` (default) or `no`
    # @param upsert [String] `yes` or `no` (default)
    def create_member(list_address, **data)
      CreateMember.new(api: api).call(list_address: list_address, **data)
    end

    # Updates a member on a mailing list.
    #
    # @example
    #   client.lists.update_member(
    #     list_address: 'list@example.com',
    #     address: 'member@example.com',
    #     subscribed: 'no',
    #   )
    #
    # @param list_address [String] Mailing list address
    # @param address [String] Member address
    # @param name [String] Mailing list name
    # @param vars [String] Additional JSON-encoded parameters
    # @param subscribed [String] `yes` (default) or `no`
    def update_member(list_address, **data)
      UpdateMember.new(api: api).call(list_address: list_address, **data)
    end

    # Removes a member from a mailing list.
    #
    # @example
    #   client.lists.remove_member(
    #     list_address: 'list@example.com',
    #     address: 'member@example.com',
    #   )
    #
    # @param list_address [String] Mailing list address
    # @param address [String] Member address
    def remove_member(list_address, **data)
      RemoveMember.new(api: api).call(list_address: list_address, **data)
    end

  protected

    attr_accessor :api
  end
end

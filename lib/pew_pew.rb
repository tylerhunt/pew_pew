require 'pew_pew/version'
require 'relax'

module PewPew
  extend Relax::Delegator[:client]

  autoload :Client, 'pew_pew/client'
  autoload :Config, 'pew_pew/config'
  autoload :Domain, 'pew_pew/domain'
  autoload :Resource, 'pew_pew/resource'
  autoload :Response, 'pew_pew/response'

  module Resources
    autoload :Bounces, 'pew_pew/resources/bounces'
    autoload :Complaints, 'pew_pew/resources/complaints'
    autoload :Logs, 'pew_pew/resources/logs'
    autoload :Mailboxes, 'pew_pew/resources/mailboxes'
    autoload :Messages, 'pew_pew/resources/messages'
    autoload :Routes, 'pew_pew/resources/routes'
    autoload :Stats, 'pew_pew/resources/stats'
    autoload :Unsubscribes, 'pew_pew/resources/unsubscribes'
  end

  # @return a memoized instance of the client
  # @!visibility private
  def self.client
    @client ||= Client.new
  end
  private_class_method :client
end

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
    autoload :Logs, 'pew_pew/resources/logs'
    autoload :Messages, 'pew_pew/resources/messages'
    autoload :Stats, 'pew_pew/resources/stats'
  end

  # @return a memoized instance of the client
  # @!visibility private
  def self.client
    @client ||= Client.new
  end
  private_class_method :client
end

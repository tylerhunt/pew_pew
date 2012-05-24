require 'pew_pew/version'
require 'relax'

module PewPew
  extend Relax::Delegator[:client]

  autoload :Client, 'pew_pew/client'
  autoload :Config, 'pew_pew/config'
  autoload :Resource, 'pew_pew/resource'
  autoload :Response, 'pew_pew/response'

  module Resources
    autoload :Stats, 'pew_pew/resources/stats'
  end

  def self.client
    @client ||= Client.new
  end
end

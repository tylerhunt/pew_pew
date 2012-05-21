require 'pew_pew/version'

module PewPew
  autoload :Config, 'pew_pew/config'
  autoload :Client, 'pew_pew/client'

  extend self

  def respond_to?(method, include_private=false)
    super || client.respond_to?(method, include_private)
  end

  def method_missing(method, *args, &block)
    if client.respond_to?(method)
      client.send(method, *args, &block)
    else
      super
    end
  end

  def client
    @client ||= Client.new
  end
  private :client
end

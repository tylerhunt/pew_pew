require 'hashie'

module PewPew
  class Response < Hashie::Mash
    def success?
      status == 200
    end
  end
end

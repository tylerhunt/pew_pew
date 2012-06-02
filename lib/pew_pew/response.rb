require 'hashie'

module PewPew
  class Response < Hashie::Mash
    undef :count

    def success?
      status == 200
    end
  end
end

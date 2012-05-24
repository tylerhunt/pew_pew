module PewPew
  module Resources
    class Stats
      include Resource
      include Domain

      def all
        get("#{domain}/stats")
      end
    end
  end
end

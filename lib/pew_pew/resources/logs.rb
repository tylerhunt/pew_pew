module PewPew
  module Resources
    class Logs
      include Resource
      include Domain

      def all
        get("#{domain}/log")
      end
    end
  end
end

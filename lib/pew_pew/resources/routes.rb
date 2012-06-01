module PewPew
  module Resources
    class Routes
      include Resource

      # Fetches all defined routes.
      #
      # @return [Mash] the response body
      def all
        get('routes')
      end

      # Fetch a route by ID.
      #
      # @param id [String] the ID of the route to be fetched
      # @return [Mash] the response body
      def find(id)
        get("routes/#{id}")
      end

      # Creates a new route.
      #
      # @option params [Fixnum] :priority smaller number indicates higher
      #   priority; higher priority routes are handled first; Defaults to 0
      # @option params [String] :description arbitrary description of the route
      # @option params [String] :expression the filter expression
      # @option params [String, Array<String>] :action the route action(s) to
      #   be executed when the expression evaluates to true
      # @return [Mash] the response body
      def create(params)
        post('routes', params)
      end

      # Updates an existing route by ID.
      #
      # @param id [String] the ID of the route to be updated
      # @option params [Fixnum] :priority smaller number indicates higher
      #   priority; higher priority routes are handled first; Defaults to 0
      # @option params [String] :description arbitrary description of the route
      # @option params [String] :expression the filter expression
      # @option params [String, Array<String>] :action the route action(s) to
      #   be executed when the expression evaluates to true
      # @return [Mash] the response body
      def update(id, params)
        put("routes/#{id}", params)
      end

      # Removes an existing route by ID.
      #
      # @param id [String] the ID of the route to be deleted
      # @return [Mash] the response body
      def remove(id)
        delete("routes/#{id}")
      end
    end
  end
end

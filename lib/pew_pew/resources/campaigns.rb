module PewPew
  module Resources
    class Campaigns
      include Resource
      include Domain

      # Fetches all campaigns for the domain.
      #
      # @return [Mash] the response body
      def all
        get("#{domain}/campaigns")
      end

      # Fetch a campaign by ID.
      #
      # @param id [String] the ID of the campaign to be fetched
      # @return [Mash] the response body
      def find(id)
        get("#{domain}/campaigns/#{id}")
      end

      # Creates a new campaign.
      #
      # @option params [String] :name the name of the campaign
      # @option params [String] :id optional campaign identifier (defaults to
      #   an generated ID)
      # @return [Mash] the response body
      def create(params)
        post("#{domain}/campaigns", params)
      end

      # Removes an existing campaign and all associated data.
      #
      # @param id [String] the ID of the campaign to be deleted
      # @return [Mash] the response body
      def remove(id)
        delete("#{domain}/campaigns/#{id}")
      end

      # Fetch the events for a campaign, including clicks, opens, unsubscribes,
      # bounces and complaints.
      #
      # @param id [String] a campaign ID
      # @option params [String, Array<String>] :event optional event filter
      #   (clicked, opened, unsubscribed, bounced, or complained)
      # @option params [String] :address optional recipient email address
      # @option params [String] :country optional two-letter country code
      # @option params [String] :region optional region name or code
      # @option params [Fixnum] :limit number of records to return (maximum 100)
      # @option params [Fixnum] :page results page number
      # @option params [Boolean] :count if true, return counts instead of
      #   records
      # @return [Mash] the response body
      def events(id, params={})
        get("#{domain}/campaigns/#{id}/events", params)
      end

      # Fetches a summary of the results for a given campaign, like numbers of
      # clicks, opens, etc. Includes unique numbers (e.g. number of unique
      # recipients who clicked) as well.
      #
      # @param id [String] a campaign ID
      # @option params [String] :group_by optional grouping (domain or
      #   daily_hour)
      # @return [Mash] the response body
      def stats(id, params={})
        params[:groupby] = params.delete(:group_by) if params[:group_by]
        get("#{domain}/campaigns/#{id}/stats", params)
      end

      # Fetches clicks aggregated by one or more parameters.
      #
      # @param id [String] a campaign ID
      # @option params [String] :group_by optional grouping (link, recipient,
      #   domain, country, region, city, month, day, hour, minute, daily_hour)
      # @option params [String] :country optional two-letter country code
      # @option params [String] :region optional region name or code
      # @option params [String] :city optional city name
      # @option params [Fixnum] :limit number of records to return (maximum 100)
      # @option params [Fixnum] :page results page number
      # @option params [Boolean] :count if true, return counts instead of
      #   records
      # @return [Mash] the response body
      def clicks(id, params={})
        params[:groupby] = params.delete(:group_by) if params[:group_by]
        get("#{domain}/campaigns/#{id}/clicks", params)
      end

      # Fetches opens aggregated by one or more parameters.
      #
      # @param id [String] a campaign ID
      # @option params [String] :group_by optional grouping (recipient, domain,
      #   country, region, city, month, day, hour, minute, daily_hour)
      # @option params [String] :country optional two-letter country code
      # @option params [String] :region optional region name or code
      # @option params [String] :city optional city name
      # @option params [Fixnum] :limit number of records to return (maximum 100)
      # @option params [Fixnum] :page results page number
      # @option params [Boolean] :count if true, return counts instead of
      #   records
      # @return [Mash] the response body
      def opens(id, params={})
        params[:groupby] = params.delete(:group_by) if params[:group_by]
        get("#{domain}/campaigns/#{id}/opens", params)
      end

      # Fetches unsubscribes aggregated by one or more parameters.
      #
      # @param id [String] a campaign ID
      # @option params [String] :group_by optional grouping (domain, country,
      #   region, city, month, day, hour, minute, daily_hour)
      # @option params [String] :country optional two-letter country code
      # @option params [String] :region optional region name or code
      # @option params [String] :city optional city name
      # @option params [Fixnum] :limit number of records to return (maximum 100)
      # @option params [Fixnum] :page results page number
      # @option params [Boolean] :count if true, return counts instead of
      #   records
      # @return [Mash] the response body
      def unsubscribes(id, params={})
        params[:groupby] = params.delete(:group_by) if params[:group_by]
        get("#{domain}/campaigns/#{id}/unsubscribes", params)
      end

      # Fetches complaints aggregated by one or more parameters.
      #
      # @param id [String] a campaign ID
      # @option params [String] :group_by optional grouping (recipient, domain,
      #   month, day, hour, minute, daily_hour)
      # @option params [Fixnum] :limit number of records to return (maximum 100)
      # @option params [Fixnum] :page results page number
      # @option params [Boolean] :count if true, return counts instead of
      #   records
      # @return [Mash] the response body
      def complaints(id, params={})
        params[:groupby] = params.delete(:group_by) if params[:group_by]
        get("#{domain}/campaigns/#{id}/complaints", params)
      end
    end
  end
end

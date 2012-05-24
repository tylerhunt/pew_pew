module PewPew
  module Domain
    def domain
      @domain ||= @options[:domain] || config.domain
    end
    private :domain
  end
  private_constant :Domain
end

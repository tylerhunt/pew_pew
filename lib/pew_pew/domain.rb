module PewPew
  module Domain
    def domain
      @domain ||= @options[:domain] || config.domain
    end
    private :domain
  end
  private_constant :Domain if respond_to?(:private_constant) # >= 1.9.3
end

require 'pew_pew'
require 'rspec/its'

# These defaults are only for use when developing this client library. Please
# do not use them in your own applications. Sign up for your own account here:
# https://mailgun.net/signup
ENV['MAILGUN_API_KEY'] ||= 'key-02n9f3ijl9sm9u97-8p7r-d7-15q-ui1'
ENV['MAILGUN_DOMAIN'] ||= 'pewpew.mailgun.org'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |file|
  require(file)
end

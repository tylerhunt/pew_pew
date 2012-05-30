# PewPew

A Ruby library for using the [Mailgun] API.

[mailgun]: https://mailgun.net/


## Installation

Add this line to your application's `Gemfile`:

``` ruby
gem 'pew_pew'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pew_pew


## Configuration

You must have a valid API key to use the Mailgun API. If you don't yet have
one, you can [sign up here][api-key].

[api-key]: http://www.mailgun.net/signup

You can use the following method to configure your API key and domain:

``` ruby
PewPew.configure do |config|
  config.api_key = ENV['MAILGUN_API_KEY']
  config.domain = ENV['MAILGUN_DOMAIN'] # optional
end
```

If you'd like to use multiple instances of the API with different keys, you can
instantiate `PewPew::Client` directly and treat those instances the same as you
would the `PewPew` module:

``` ruby
pew_pew = PewPew::Client.new

pew_pew.configure do |config|
  config.api_key = ENV['MAILGUN_API_KEY']
  config.domain = ENV['MAILGUN_DOMAIN'] # optional
end
```


## Usage

Once the API key has been configured, resources can be called on the `PewPew`
module directly or off your client instances:

``` ruby
PewPew.logs.all

PewPew.messages.send_email(
  to: 'to@example.com',
  from: 'from@example.com',
  subject: 'Test',
  text: 'This is a test message.'
)

PewPew.stats.all
```

For resources that require a domain, you may pass it as an option when calling
the resource. If a domain has been configured, it will be used as the default.

``` ruby
PewPew.stats.all # uses the configured domain
PewPew.stats(domain: 'example.com').all # uses example.com
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature.'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

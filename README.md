# Pew Pew

A Ruby client library for using the [Mailgun][] web service.

[mailgun]: https://www.mailgun.com

[![Build][build-image]][build]
[![Maintainability][codeclimate-image]][codeclimate]
[![Gem Version][rubygems-image]][rubygems]

[build]: https://github.com/tylerhunt/pew_pew/actions/workflows/main.yml?query=branch%3Amaster
[build-image]: https://github.com/tylerhunt/pew_pew/actions/workflows/main.yml/badge.svg
[codeclimate]: https://codeclimate.com/github/tylerhunt/pew_pew/maintainability
[codeclimate-image]: https://api.codeclimate.com/v1/badges/65a20ce39216677c4b8a/maintainability
[rubygems]: https://badge.fury.io/rb/pew_pew
[rubygems-image]: https://badge.fury.io/rb/pew_pew.svg

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'pew_pew'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pew_pew

## Configuration

You must have a valid API key to use the Mailgun API. If you don't yet have
one, you can [sign up here][api-key].

[api-key]: https://signup.mailgun.com/new/signup

Assuming the `MAILGUN_API_KEY` environment variable is present:

```ruby
client = PewPew::Client.new
```

## Usage

Once the API key has been configured, resources can be called on the client:

``` ruby
client.lists.create(address: 'list@example.com')
```

See the [documentation][] for the complete [list of resources][resources].

[documentation]: https://rubydoc.info/gems/pew_pew
[resources]: https://rubydoc.info/gems/pew_pew/PewPew/Resources

## Contributing

The following environment variables are required to run the specs:

  - `MAILGUN_API_KEY`
  - `MAILGUN_DOMAIN`

Bug reports and pull requests are welcome on [GitHub][].

[github]: https://github.com/tylerhunt/pew_pew

## License

The gem is available as open source under the terms of the [MIT License][mit].

[mit]: https://opensource.org/licenses/MIT

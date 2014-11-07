# Eventhub::Components

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'eventhub-components'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventhub-components

## Usage

This Gem provides shared code for processors and the console app.

### Logger

Provides a second argument (a hash) to the log methods (debug, info, ...)

''''
logger = Eventhub::Components::Logger.new(some_other_logger, 'app_name' => 'my fancy app', 'env' => 'staging')
logger.info("my message", :foo => 1, :bar => 2)
''''

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eventhub-components/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

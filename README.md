[![Gem Version](https://badge.fury.io/rb/eventhub-components.svg)](https://badge.fury.io/rb/eventhub-components)
[![Maintainability](https://api.codeclimate.com/v1/badges/3f6c9e1a8d32388df0fa/maintainability)](https://codeclimate.com/github/thomis/eventhub-components/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/3f6c9e1a8d32388df0fa/test_coverage)](https://codeclimate.com/github/thomis/eventhub-components/test_coverage)
[![ci](https://github.com/thomis/eventhub-components/actions/workflows/ci.yml/badge.svg)](https://github.com/thomis/eventhub-components/actions/workflows/ci.yml)

# EventHub::Components

Incldues logging, exception writing and pid file facilities for event hub processors.

## Installation

Add this line to your application's Gemfile:

    gem 'eventhub-components'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventhub-components

## Usage

    require 'eventhub/components'

## Pid Files

Takes care of writing, reading and deleting a PID file

    pid_file = EventHub::Components::PidFile.new('my_application.pid')
    pid_file.write # writes Process.pid
    # or
    pid_file.write(some_process_pid)

    pid_file.read # => "some_pid" (it's a string as it comes from a file)

    pid_file.delete


## Logging

#### StructuredDataLogger

Provides a second argument (a hash) to the log methods (debug, info, ...)

    logger = EventHub::Components::StructuredDataLogger.new(some_other_logger, 'app_name' => 'my fancy app', 'env' => 'staging')
    logger.info("my message", :foo => 1, :bar => 2)


## MultiLogger

Forwards calls to all devices that have been added to the multilogger.

    logger = EventHub::Components::MultiLogger.new
    logger.add_device(some_other_logger_1)
    logger.add_device(some_other_logger_2)
    logger.info("Hans")

## ExceptionWriter

Helps writing exceptions and log messages to files. It creates

    writer = EventHub::Components::ExceptionWriter.new() # logs to ./exceptions
    # or
    writer = EventHub::Components::ExceptionWriter.new('some_dir', max_number_of_files) # logs to ./exceptions/some_dir

    writer.write(e)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/eventhub-components/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

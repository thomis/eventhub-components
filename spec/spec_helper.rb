require 'bundler/setup'
Bundler.setup
require 'rspec'
require_relative '../lib/eventhub/components'

RSpec.configure do |config|
  #config.mock_with :rspec
end


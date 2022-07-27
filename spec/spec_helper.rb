require "simplecov"
SimpleCov.start

require "bundler/setup"
Bundler.setup
require "rspec"
require_relative "../lib/eventhub/components"

RSpec.configure do |config|
end

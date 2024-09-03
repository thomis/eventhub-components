lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "eventhub/components/version"

Gem::Specification.new do |spec|
  spec.name = "eventhub-components"
  spec.version = EventHub::Components::VERSION
  spec.authors = ["Steiner, Thomas"]
  spec.email = ["thomas.steiner@ikey.ch"]
  spec.summary = "Additional eventhub components"
  spec.description = "Additional eventhub components"
  spec.homepage = "https://github.com/thomis/eventhub-components"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.2"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "standard", "~> 1.39"
  spec.add_development_dependency "simplecov", "~> 0.21"

  spec.add_runtime_dependency "logstash-logger", "~> 0.26"
  spec.add_runtime_dependency "logger", "~> 1.6"
end

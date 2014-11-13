# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventhub/components/version'

Gem::Specification.new do |spec|
  spec.name          = "eventhub-components"
  spec.version       = EventHub::Components::VERSION
  spec.authors       = ["Novartis"]
  spec.email         = ["pascal.betz@simplificator.com"]
  spec.summary       = %q{EventHub Components utilities}
  spec.description   = %q{EventHub Components utilities}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', "~> 3.1.0"
end

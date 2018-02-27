# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventhub/components/version'

Gem::Specification.new do |spec|
  spec.name          = 'eventhub-components'
  spec.version       = EventHub::Components::VERSION
  spec.authors       = ['Steiner, Thomas']
  spec.email         = ['thomas.steiner@ikey.ch']
  spec.summary       = 'Additional eventhub components'
  spec.description   = 'Additional eventhub components'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_runtime_dependency 'logstash-logger', '~> 0.26'
end

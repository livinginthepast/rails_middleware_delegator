# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_middleware_delegator/version'

Gem::Specification.new do |spec|
  spec.name        = 'rails_middleware_delegator'
  spec.version     = RailsMiddlewareDelegator::VERSION
  spec.authors     = ['Eric Saxby']
  spec.email       = ['sax@livinginthepast.org']

  spec.summary     = 'Wraps a reloadable class to be used as Rails middleware.'
  spec.description = 'Wraps a reloadable class to be used as Rails middleware.'
  spec.homepage    = 'https://github.com/livinginthepast/rails_middleware_delegator'
  spec.license     = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'

  spec.add_dependency 'activesupport'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber/instafail/version'

Gem::Specification.new do |spec|
  spec.name          = 'cucumber-instafail'
  spec.version       = Cucumber::Instafail::VERSION
  spec.authors       = ['Guillaume Hain']
  spec.email         = ['zedtux@zedroot.org']
  spec.summary       = 'Show failing features instantly'
  spec.description   = 'Show failing features instantly. Show passing spec ' \
                       'as green dots as usual. Highly inspired by ' \
                       'rspec-instafail from grosser ' \
                       '(https://github.com/grosser).'
  spec.homepage      = 'https://github.com/zedtux/cucumber-instafail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
end

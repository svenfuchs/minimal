# encoding: utf-8

require File.expand_path('../lib/minimal/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'minimal'
  s.version      = Minimal::VERSION
  s.authors      = ['Sven Fuchs']
  s.email        = 'svenfuchs@artweb-design.de'
  s.homepage     = 'http://github.com/svenfuchs/minimal'
  s.summary      = 'Minimal templating engine inspired by Markaby & Erector'
  s.description  = 'Minimal templating engine inspired by Markaby & Erector and targeted at Rails 3.'
  s.files        = Dir['{lib/**/*,[A-Z]*}']

  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  s.required_rubygems_version = '>= 1.3.6'

  rails_version = '>=3.0.0'
  s.add_dependency 'actionpack', rails_version
  s.add_dependency 'activesupport', rails_version

  s.add_development_dependency 'test_declarative'
end

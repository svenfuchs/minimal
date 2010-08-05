$:.unshift File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'test_declarative'
require 'pp'
require 'minimal'

alias :require_dependency :require

Minimal::Template.send(:include, Minimal::Template::FormBuilderProxy)
ActionView::Template.register_template_handler('rb', Minimal::Template::Handler)

ActionView::Base.class_eval { def protect_against_forgery?; false end } # HAX

VIEW_PATH = File.expand_path('../fixtures/views', __FILE__)
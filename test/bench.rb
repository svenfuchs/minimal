$: << File.expand_path('../../lib', __FILE__)

require 'erb'
require 'minimal'
require 'benchmark'

alias :require_dependency :require

Minimal::Template.send(:include, Minimal::Template::FormBuilderProxy)
ActionView::Template.register_template_handler('rb', Minimal::Template::Handler)
ActionView::Base.class_eval { def protect_against_forgery?; false end } # HAX

VIEW_PATH = File.expand_path('../fixtures/views', __FILE__)
view = ActionView::Base.new(VIEW_PATH)
view.output_buffer = ActiveSupport::SafeBuffer.new

Benchmark.bmbm do |b|
  b.report("erb")      { 5000.times { view.render(:file => 'bench/erb') } }
  b.report("minimal")  { 5000.times { view.render(:file => 'bench/minimal')  } }
end
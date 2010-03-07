$: << File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'test/unit'
require 'pp'
require 'minimal'
require 'action_controller'
require 'active_model'

Minimal::Template.send(:include, Minimal::Template::FormBuilderProxy)

ActionView::Template.register_template_handler('rb', Minimal::Template::Handler)

ActionView::Base.class_eval { def protect_against_forgery?; false end } # HAX

module TestMethod
  def self.included(base)
    base.class_eval do
      def test(name, &block)
        test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
        defined = instance_method(test_name) rescue false
        raise "#{test_name} is already defined in #{self}" if defined
        if block_given?
          define_method(test_name, &block)
        else
          define_method(test_name) do
            flunk "No implementation provided for #{name}"
          end
        end
      end
    end
  end
end

class Module
  include TestMethod
end

class Test::Unit::TestCase
  include TestMethod
end
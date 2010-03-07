class Minimal::Template
  autoload :FormBuilderProxy, 'minimal/template/form_builder_proxy'

  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require template.identifier
      klass = template.identifier =~ %r(views/(.*).rb) && $1.camelize
      "@output_buffer = ActiveSupport::SafeBuffer.new;#{klass}.new(self)._render(local_assigns)"
    end
  end

  AUTO_BUFFER = %r(render|tag|error_message_|select|debug|_to|_for)

  TAG_NAMES = %w(a body div em fieldset form h1 h2 h3 h4 head html img input
    label li link ol option p pre script select span strong table td th tr ul)

  module Base
    attr_reader :view, :buffers, :locals

    def initialize(view = nil)
      @view, @buffers = view, []
    end

    def _render(locals = nil)
      @locals = locals || {}
      content
    end

    TAG_NAMES.each do |name|
      define_method(name) { |*args, &block| content_tag(name, *args, &block) }
    end

    def <<(output)
      view.output_buffer << output
    end

    protected

      def method_missing(method, *args, &block)
        locals.key?(method) ? locals[method] :
          view.instance_variable_defined?("@#{method}") ? view.instance_variable_get("@#{method}") :
          view.respond_to?(method) ? call_view(method, *args, &block) : super
      end

      def call_view(method, *args, &block)
        result = view.capture { view.send(method, *args, &block) }
        AUTO_BUFFER =~ method.to_s ? self << result : result
      end
  end
  include Base
end
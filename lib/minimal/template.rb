class Minimal::Template
  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require template.identifier
      <<-code
        @output_buffer = ActiveSupport::SafeBuffer.new
        #{template.identifier =~ %r(views/(.*).rb) && $1.camelize}.new(self).to_s(local_assigns)
      code
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

    def to_s(locals = nil)
      @locals = locals || {}
      content
    end

    protected

      TAG_NAMES.each do |tag_name|
        define_method(tag_name) { |*args, &block| content_tag(tag_name, *args, &block) }
      end

      def <<(output)
        view.output_buffer << output
      end

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
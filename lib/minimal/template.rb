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

  BUFFERED = %r(render|_tag|error_message_|select|debug|_for|_to)

  TAG_NAMES = %w(a body div fieldset form h1 h2 h3 h4 head html img input
    label li link ol option p pre script select span table td th tr ul)

  module Base
    attr_reader :view, :buffers, :locals

    def initialize(view = nil)
      @view, @buffers = view, []
    end

    def to_s(locals = nil)
      @locals = locals || {}
      capture { content }
    end

    protected

      TAG_NAMES.each do |tag_name|
        define_method(tag_name) do |*args, &block|
          self << view.content_tag(tag_name, *args) { block ? capture(&block) : args.first }
        end
      end

      def <<(output)
        buffers.last << output
      end

      def capture(*args, &block)
        buffers << ActiveSupport::SafeBuffer.new
        result = yield(*args)
        self << result if buffers.last.empty?
        buffers.pop
      end

      def method_missing(method, *args, &block)
        locals.key?(method) ? locals[method] :
          view.instance_variable_defined?("@#{method}") ? view.instance_variable_get("@#{method}") :
          view.respond_to?(method) ? call_view(method, *args, &block) : super
      end

      def call_view(method, *args, &block)
        result = block ? view.send(method, *args) { |*args| capture(*args, &block) } : view.send(method, *args)
        self << result if BUFFERED =~ method.to_s
        result
      end
  end
  include Base
end
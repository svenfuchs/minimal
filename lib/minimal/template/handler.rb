class Minimal::Template
  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require_dependency template.identifier
      <<-code
        @output_buffer = ActiveSupport::SafeBuffer.new
        #{template_class_name(template.identifier)}.new(self)._render(local_assigns) { yield }
      code
    end

    protected

      def template_class_name(path)
        path =~ %r(views/(.*).rb) && $1.gsub('.', '/').camelize
      end
  end
end
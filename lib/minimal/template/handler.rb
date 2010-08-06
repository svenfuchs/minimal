class Minimal::Template
  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require_dependency template.identifier
      class_name, format = template_class_name_and_format(template.identifier)
      <<-code
        @output_buffer = ActiveSupport::SafeBuffer.new
        template, format = #{class_name}, #{format.inspect}
        template.new(self)._render(local_assigns, format) { |*args| yield(*args) }
      code
    end

    protected

      def template_class_name_and_format(path)
        %r(views/(.*?)(\.[^\.]*)?.rb) =~ path
        [$1.try(:camelize), ($2 || 'html').gsub('.', '').to_sym]
      end
  end
end
class Minimal::Template
  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require_dependency template.identifier
      klass = template.identifier =~ %r(views/(.*).rb) && $1.camelize
      "@output_buffer = ActiveSupport::SafeBuffer.new;#{klass}.new(self)._render(local_assigns)"
    end
  end
end

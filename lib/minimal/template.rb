class Template
  class Handler < ActionView::Template::Handler
    include ActionView::Template::Handlers::Compilable

    def compile(template)
      require template.identifier
      "#{template.identifier =~ %r((views/.*).rb) && $1.camelize}.new(self).to_s(local_assigns)"
    end
  end
  ActionView::Template.register_template_handler('rb', Handler)

  cattr_reader :tag_names
  @@tag_names = %w(a body div fieldset form h1 h2 h3 h4 head html img input
    label li link ol option p pre script select span table td th tr ul)

  attr_reader :view, :buffers, :locals

  def initialize(view)
    @view, @buffers = view, []
  end

  def to_s(locals = {})
    @locals = locals
    capture { content }
  end

  protected

    def out(out)
      buffers.last << out
    end

    tag_names.each do |tag_name|
      define_method(tag_name) do |*args, &block|
        buffers.last << @view.content_tag(tag_name, *args) { capture(&block) if block }
      end
    end

    def capture(&block)
      buffers << ''.html_safe
      yield
      buffers.pop
    end

    def method_missing(method, *args, &block)
      return locals[method] if locals.key?(method)
      return view.send(method, *args, &block) if view.respond_to?(method)
      return view.instance_variable_get("@#{method}") if view.instance_variable_defined?("@#{method}")
      super
    end
end
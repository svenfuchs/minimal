class Minimal::Template
  TRANSLATED_TAGS = %w(link_to button_to a div em h1 h2 h3 h4 h5 h6 label li
    option p pre span strong td title)

  module TranslatedTags
    TRANSLATED_TAGS.each do |name|
      define_method(name) do |*args, &block|
        args[0] = t(args[0]).html_safe if args[0].is_a?(Symbol)
        super(*args, &block)
      end
    end
  end
end
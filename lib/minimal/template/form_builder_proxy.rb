class Minimal::Template
  module FormBuilderProxy
    PROXY_TAGS = [:form_for, :fields_for]

    class Proxy
      attr_reader :template, :builder

      def initialize(template, builder)
        @template, @builder = template, builder
      end

      def method_missing(method, *args, &block)
        if PROXY_TAGS.include?(method)
          template << builder.send(method, *args) do |builder|
            yield(Proxy.new(template, builder))
          end
        else
          template << builder.send(method, *args, &block)
        end
      end
    end

    def method_missing(method, *args, &block)
      if PROXY_TAGS.include?(method)
        self << view.send(method, *args) do |builder|
          yield(Proxy.new(self, builder))
        end
      else
        super
      end
    end
  end
end
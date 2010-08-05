class Minimal::Template
  module FormBuilderProxy
    class Proxy
      attr_reader :template, :builder

      def initialize(template, builder)
        @template, @builder = template, builder
      end

      def method_missing(method, *args, &block)
        if [:form_for, :fields_for].include?(method)
          template << builder.send(method, *args) do |builder|
            yield(Proxy.new(template, builder))
          end
        else
          template << builder.send(method, *args, &block)
        end
      end
    end

    def method_missing(method, *args, &block)
      if [:form_for, :fields_for].include?(method)
        self << view.send(method, *args) do |builder|
          yield(Proxy.new(self, builder))
        end
      else
        super
      end
    end
  end
end
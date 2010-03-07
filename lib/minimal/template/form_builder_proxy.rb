class Minimal::Template
  module FormBuilderProxy
    class Proxy
      attr_reader :template, :builder

      def initialize(template, builder)
        @template, @builder = template, builder
      end

      def method_missing(method, *args, &block)
        template << builder.send(method, *args, &block)
      end
    end

    def method_missing(method, *args, &block)
      if [:form_for, :fields_for].include?(method)
        view.form_for(*args) { |builder| yield(Proxy.new(self, builder)) }
      else
        super
      end
    end
  end
end
module Views
  module Foo 
    class Bar < Template
      def content
        h1 { out 'plain' }
        p  { out local }
      end
    end
  end
end
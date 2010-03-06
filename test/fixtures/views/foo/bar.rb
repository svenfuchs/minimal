module Foo
  class Bar < Minimal::Template
    def content
      html do
        head
        body do
          h1 { 'plain' }
          p  { local }
        end
      end
    end
  end
end
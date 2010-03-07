module Foo
  class Simple < Minimal::Template
    def content
      html do
        head
        body do
          h1 'plain'
          bar
          div { div { 'nested' }}
        end
      end
    end

    def bar
      p { local }
    end
  end
end
module Foo
  class Layout < Minimal::Template
    def to_html
      html do
        head
        body do
          yield
          sidebar
        end
      end
    end

    def sidebar
      block.call :sidebar
    end
  end
end
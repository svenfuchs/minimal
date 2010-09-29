module Foo
  class Ivar < Minimal::Template
    def to_html
      p { @foo }
    end
  end
end
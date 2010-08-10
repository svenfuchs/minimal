module Foo
  class Translated < Minimal::Template
    def to_html
      p :foo
    end
  end
end
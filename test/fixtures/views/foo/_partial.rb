module Foo
  class Partial < Minimal::Template
    def to_html
      p local
    end
  end
end
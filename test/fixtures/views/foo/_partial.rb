module Foo
  class Partial < Minimal::Template
    def content
      p local
    end
  end
end
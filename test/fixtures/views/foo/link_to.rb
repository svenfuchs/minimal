module Foo
  class LinkTo < Minimal::Template
    def content
      link_to 'foo', '#'
    end
  end
end
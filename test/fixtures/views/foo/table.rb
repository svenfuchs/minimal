module Foo
  class Table < Minimal::Template
    def content
      table do
        tr do
          %w(foo bar baz).each { |text| td text }
        end
      end
    end
  end
end
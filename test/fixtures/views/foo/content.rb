module Foo
  class Content < Minimal::Template
    def to_html
      div 'content'
      content_for(:sidebar) { div 'sidebar' }
    end
  end
end
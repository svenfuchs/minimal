module Foo
  class FormTag < Minimal::Template
    def content
      div 'foo'
      form_tag '/foo' do
        div { text_field_tag 'bar' }
        text_field_tag 'baz'
      end
    end
  end
end
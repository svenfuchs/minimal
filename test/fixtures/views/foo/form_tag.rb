module Foo
  class FormTag < Minimal::Template
    def to_html
      div 'foo'
      form_tag '/foo' do
        div { text_field_tag('bar') }
        text_field_tag('baz')
      end
    end
  end
end
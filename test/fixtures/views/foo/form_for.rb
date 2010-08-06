module Foo
  class FormFor < Minimal::Template
    def to_html
      div 'foo'
      form_for 'foo', :url => '/foo' do |f|
        div { f.text_field('bar') }
        f.text_field('baz')
      end
    end
  end
end
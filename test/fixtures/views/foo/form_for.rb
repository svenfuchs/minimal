module Foo
  class FormFor < Minimal::Template
    def content
      div 'foo'
      form_for 'foo', :url => '/foo' do |f|
        div { f.text_field 'bar' }
        self << f.text_field('baz') # can't be auto_buffered w/o proxying f?
      end
    end
  end
end
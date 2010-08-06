module Foo
  class FieldsFor < Minimal::Template
    def to_html
      form_for 'form', :url => '/foo' do |f|
        f.select('foo', ['1'])
        f.fields_for(:outer) do |b|
          b.select('bar', ['1'])
          b.fields_for(:inner) do |c|
            c.select('baz', ['1'])
          end
        end
      end
    end
  end
end
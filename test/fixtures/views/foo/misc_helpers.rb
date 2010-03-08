module Foo
  class MiscHelpers < Minimal::Template
    def content
      image_tag('http://no-asset-host.com/rails.png')
      debug('foo')
      javascript_tag("alert('All is good')")
      div_for(Record.new) { self << 'content' }
      tag('br')
      content_tag(:p, 'Hello world!')
      content_tag(:p) { self << 'Hello world!' }
      content_tag(:p) { em 'Hello world!' }
      content_tag(:p) { em { self << 'Hello world!' } }
      link_to('foo', '#')
    end
  end
end

module Foo
  class Bar < Minimal::Template
    def content
      html do
        head
        body do
          h1 'plain'
          bar
          div do
            render :partial => 'foo/partial', :locals => { :local => 'partial' }
          end
        end
      end
    end

    def bar
      p  { local }
    end
  end
end
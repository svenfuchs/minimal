module Foo
  class Partial < Minimal::Template
    def content
      div do
        render :partial => 'foo/partial', :locals => { :local => 'partial' }
      end
      render :partial => 'foo/partial', :locals => { :local => 'partial' }
    end
  end
end
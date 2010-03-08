module Foo
  class Partial < Minimal::Template
    def content
      div do
        %w(foo bar).each do |local|
          render :partial => 'foo/partial', :locals => { :local => local }
        end
      end
      render :partial => 'foo/partial', :locals => { :local => 'baz' }
    end
  end
end
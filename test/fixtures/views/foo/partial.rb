module Foo
  class Partial < Minimal::Template
    def to_html
      div do
        %w(foo bar).each do |local|
          render :partial => 'foo/partial', :locals => { :local => local }
        end
      end
      render :partial => 'foo/partial', :locals => { :local => 'baz' }
    end
  end
end
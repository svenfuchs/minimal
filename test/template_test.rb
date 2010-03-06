require File.expand_path('../test_helper', __FILE__)

class TemplateTest < Test::Unit::TestCase
  def setup
    @view = ActionView::Base.new(File.expand_path('../fixtures/views', __FILE__))
  end
  
  test "simple render with local assigns" do
    assert_equal '<h1>plain</h1><p>local</p>', @view.render(:file => 'foo/bar', :locals => { :local => 'local' })
  end
end
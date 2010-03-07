require File.expand_path('../test_helper', __FILE__)

class TemplateTest < Test::Unit::TestCase
  def setup
    @view = ActionView::Base.new(File.expand_path('../fixtures/views', __FILE__))
  end
  
  test "simple render with local assigns" do
    html = '<html><head></head><body><h1>plain</h1><p>local</p><div><div>nested</div></div></body></html>'
    assert_equal html, @view.render(:file => 'foo/simple', :locals => { :local => 'local' })
  end
  
  test "partial rendering" do
    html = '<div><p>partial</p></div><p>partial</p>'
    assert_equal html, @view.render(:file => 'foo/partial')
  end
  
  test "link_to" do
    html = '<a href="#">foo</a>'
    assert_equal html, @view.render(:file => 'foo/link_to')
  end
  
  test "form_tag with input_tags" do
    html = '<div>foo</div>' + 
      '<form action="/foo" method="post">' + 
      '<div><input id="bar" name="bar" type="text" /></div>' + 
      '<input id="baz" name="baz" type="text" />' + 
      '</form>'
    assert_equal html, @view.render(:file => 'foo/form_tag')
  end
  
  test "form_for" do
    html = '<div>foo</div>' + 
      '<form action="/foo" method="post">' + 
      '<div><input id="bar" name="bar" type="text" /></div>' + 
      '<input id="baz" name="baz" type="text" />' + 
      '</form>'
    assert_equal html, @view.render(:file => 'foo/form_for')
  end
end
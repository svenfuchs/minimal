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
      '<div><input id="foo_bar" name="foo[bar]" size="30" type="text" /></div>' +
      '<input id="foo_baz" name="foo[baz]" size="30" type="text" />' +
      '</form>'
    assert_equal html, @view.render(:file => 'foo/form_for')
  end

  test "misc_helpers" do
    html = <<-html.gsub("\n", '').gsub('      ', '')
      <img alt="Rails" src="http://no-asset-host.com/rails.png" />
      <pre class='debug_dump'>--- foo</pre>
      <script type="text/javascript">//<![CDATA[alert('All is good')//]]></script>
      <div class="record" id="record_1">content</div>
      <br />
      <p>Hello world!</p>
      <p>Hello world!</p>
      <p><em>Hello world!</em></p>
      <p><em>Hello world!</em></p>
      <a href="#">foo</a>
    html
    assert_equal html, @view.render(:file => 'foo/misc_helpers').gsub("\n", '')
  end
end
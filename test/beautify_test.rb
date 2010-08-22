require File.expand_path('../test_helper', __FILE__)

class BeautifyTest < Test::Unit::TestCase
  test "beautify does not touch the content-type meta tag" do
    html = '<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head></html>'
    html = Minimal::Template::BeautifyHtml.tidy(html)
    assert html.include?('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">')
  end
end
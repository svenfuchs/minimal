require File.expand_path('../test_helper', __FILE__)

class TemplateHandlerTest < Test::Unit::TestCase
  def template_class_name(path)
    handler = Minimal::Template::Handler.new
    handler.send(:template_class_name, path)
  end

  test "template_class_name without a mime type" do
    assert_equal 'Foo::Bar', template_class_name('path/to/views/foo/bar.rb')
  end

  test "template_class_name with a mime type" do
    assert_equal 'Foo::Bar::Html', template_class_name('path/to/views/foo/bar.html.rb')
    assert_equal 'Foo::Bar::Css', template_class_name('path/to/views/foo/bar.css.rb')
  end
end
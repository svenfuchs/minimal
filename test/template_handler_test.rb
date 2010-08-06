require File.expand_path('../test_helper', __FILE__)

class TemplateHandlerTest < Test::Unit::TestCase
  def template_class_name_and_format(path)
    handler = Minimal::Template::Handler.new
    handler.send(:template_class_name_and_format, path)
  end

  test "template_class_name_and_format without a mime type" do
    assert_equal ['Foo::Bar', :html], template_class_name_and_format('path/to/views/foo/bar.rb')
  end

  test "template_class_name_and_format with a mime type" do
    assert_equal ['Foo::Bar', :html], template_class_name_and_format('path/to/views/foo/bar.html.rb')
    assert_equal ['Foo::Bar', :css],  template_class_name_and_format('path/to/views/foo/bar.css.rb')
  end
end
require File.expand_path('../test_helper', __FILE__)

class TranslatedTagsTest < Test::Unit::TestCase
  def setup
    @view = @template = nil
    I18n.backend.store_translations :en, :foo => 'FOO'
  end

  def view
    @view ||= ActionView::Base.new(VIEW_PATH).tap do |view|
      view.output_buffer = ActiveSupport::SafeBuffer.new rescue ''
    end
  end

  def template
    @template ||= Minimal::Template.new(view)
  end

  test "keys given as content will be translated" do
    assert_equal '<p>FOO</p>', view.render(:file => 'foo/translated')
  end
end
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'formats page specific title' do
    content_for(:title) { 'Home' }
    assert_equal "Home | #{t('pazii')}", title
  end

  test 'returns app name when page title is missing' do
    assert_equal "#{t('pazii')}", title
  end
end

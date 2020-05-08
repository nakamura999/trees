require 'test_helper'

class StylesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get styles_index_url
    assert_response :success
  end

  test "should get show" do
    get styles_show_url
    assert_response :success
  end

  test "should get new" do
    get styles_new_url
    assert_response :success
  end

  test "should get edit" do
    get styles_edit_url
    assert_response :success
  end

end

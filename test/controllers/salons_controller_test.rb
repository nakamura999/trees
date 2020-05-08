require 'test_helper'

class SalonsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get salons_new_url
    assert_response :success
  end

  test "should get edit" do
    get salons_edit_url
    assert_response :success
  end

end

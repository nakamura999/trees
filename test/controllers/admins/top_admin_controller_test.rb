require 'test_helper'

class Admins::TopAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_top_admin_index_url
    assert_response :success
  end

end

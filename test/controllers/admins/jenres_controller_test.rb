require 'test_helper'

class Admins::JenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_jenres_index_url
    assert_response :success
  end

  test "should get edit" do
    get admins_jenres_edit_url
    assert_response :success
  end

end

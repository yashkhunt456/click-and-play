require "test_helper"

class BoxhouseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boxhouse_index_url
    assert_response :success
  end

  test "should get show" do
    get boxhouse_show_url
    assert_response :success
  end

  test "should get new" do
    get boxhouse_new_url
    assert_response :success
  end

  test "should get edit" do
    get boxhouse_edit_url
    assert_response :success
  end
end

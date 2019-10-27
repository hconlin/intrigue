require 'test_helper'

class SlidesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get slides_create_url
    assert_response :success
  end

  test "should get destroy" do
    get slides_destroy_url
    assert_response :success
  end

  test "should get new" do
    get slides_new_url
    assert_response :success
  end

end

require 'test_helper'

class BandsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get bands_edit_url
    assert_response :success
  end

end
